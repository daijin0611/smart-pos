package org.haut.aspect;

import cn.hutool.json.JSONUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.haut.common.annotation.OperLog;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.system.entity.SysOperLog;
import org.haut.server.system.service.SysOperLogService;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.Date;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class OperLogAspect {

    private final SysOperLogService sysOperLogService;

    @Around("@annotation(operLog)")
    public Object around(ProceedingJoinPoint joinPoint, OperLog operLog) throws Throwable {
        long startTime = System.currentTimeMillis();

        ServletRequestAttributes attributes =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes != null ? attributes.getRequest() : null;

        SysOperLog sysOperLog = new SysOperLog();
        sysOperLog.setModule(operLog.module().getCode());
        sysOperLog.setDescription(operLog.description());
        sysOperLog.setCreateTime(new Date());

        AuthInfoDTO auth = AuthContextHolder.getAuth();
        if (auth != null) {
            sysOperLog.setOperatorId(auth.getUserId());
            sysOperLog.setOperatorName(auth.getUserName());
            sysOperLog.setOrgId(auth.getOrgId());
        }

        if (request != null) {
            sysOperLog.setRequestMethod(request.getMethod());
            sysOperLog.setRequestUrl(request.getRequestURI());
            sysOperLog.setIp(getIpAddress(request));
        }

        Object[] args = joinPoint.getArgs();
        if (args.length > 0) {
            try {
                String params = JSONUtil.toJsonStr(args);
                sysOperLog.setRequestParams(
                        params.length() > 2000 ? params.substring(0, 2000) : params);
            } catch (Exception e) {
                sysOperLog.setRequestParams("参数序列化失败");
            }
        }

        Object result;
        try {
            result = joinPoint.proceed();
            sysOperLog.setStatus(0);
            if (operLog.saveResponse() && result != null) {
                try {
                    String responseJson = JSONUtil.toJsonStr(result);
                    sysOperLog.setResponseResult(
                            responseJson.length() > 2000 ? responseJson.substring(0, 2000) : responseJson);
                } catch (Exception e) {
                    sysOperLog.setResponseResult("响应序列化失败");
                }
            }
        } catch (Throwable e) {
            sysOperLog.setStatus(1);
            String errorMsg = e.getMessage();
            sysOperLog.setErrorMsg(
                    StringUtils.isNotBlank(errorMsg) && errorMsg.length() > 2000
                            ? errorMsg.substring(0, 2000) : errorMsg);
            throw e;
        } finally {
            sysOperLog.setCostTime(System.currentTimeMillis() - startTime);
            try {
                sysOperLogService.saveLog(sysOperLog);
            } catch (Exception e) {
                log.error("保存操作日志失败", e);
            }
        }

        return result;
    }

    private String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (StringUtils.isBlank(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (StringUtils.isBlank(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (StringUtils.isNotBlank(ip) && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }
}