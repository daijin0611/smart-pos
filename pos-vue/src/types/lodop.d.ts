// src/types/lodop.d.ts

/** 线条类型枚举 */
type LineStyle = 0 | 1 | 2 | 3 | 4; // 0-实线 1-破折线 2-点线 3-点划线 4-双点划线

/** 打印方向枚举 */
type PrintOrient = 0 | 1 | 2 | 3; // 0-默认 1-纵向 2-横向 3-纵向自适应高度

/** 对齐方式枚举 */
type Alignment = 1 | 2 | 3; // 1-左对齐 2-居中 3-右对齐

/** 打印项类型枚举 */
type ItemType = 0 | 1 | 2 | 3 | 4; // 0-普通项 1-页眉页脚 2-页号项 3-页数项 4-多页项

/** 水平锁定方式枚举 */
type HOrient = 0 | 1 | 2 | 3; // 0-左边距锁定 1-右边距锁定 2-水平居中 3-双向拉伸

/** 垂直锁定方式枚举 */
type VOrient = 0 | 1 | 2 | 3; // 0-上边距锁定 1-下边距锁定 2-垂直居中 3-双向拉伸

/** 图片缩放模式枚举 */
type StretchMode = 0 | 1 | 2; // 0-截取 1-变形缩放 2-等比缩放

/** 图表类型枚举 */
type ChartType = 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10; // 0-折线图 1-柱状图 ... 10-几何图

/** 条码类型枚举 */
type BarcodeType =
  | '128A'
  | '128B'
  | '128C'
  | '128Auto'
  | 'EAN8'
  | 'EAN13'
  | 'EAN128A'
  | 'EAN128B'
  | 'EAN128C'
  | 'Code39'
  | '39Extended'
  | '2_5interleaved'
  | '2_5industrial'
  | '2_5matrix'
  | 'UPC_A'
  | 'UPC_E0'
  | 'UPC_E1'
  | 'UPCsupp2'
  | 'UPCsupp5'
  | 'Code93'
  | '93Extended'
  | 'MSI'
  | 'PostNet'
  | 'Codabar'
  | 'QRCode'
  | 'PDF417';

/** 显示模式类型枚举 */
type ShowModeType =
  | 'PREVIEW_IN_BROWSE'
  | 'SETUP_IN_BROWSE'
  | 'DESIGN_IN_BROWSE'
  | 'BKIMG_IN_PREVIEW'
  | 'SKIN_TYPE'
  | 'LANGUAGE'
  | 'HIDE_PBUTTIN_PREVIEW'
  | 'PREVIEW_NO_MINIMIZE'
  | 'BKIMG_PRINT'
  | 'SETUP_ENABLESS'
  | 'NP_NO_RESULT';

/** 打印模式类型枚举 */
type PrintModeType =
  | 'DOUBLE_SIDED_PRINT'
  | 'PRINT_START_PAGE'
  | 'PRINT_END_PAGE'
  | 'PRINT_PAGE_PERCENT'
  | 'AUTO_CLOSE_PREWINDOW'
  | 'POS_BASEON_PAPER'
  | 'CUSTOM_TASK_NAME'
  | 'RESELECT_PRINTER'
  | 'PRINT_DUPLEX'
  | 'PRINT_NOCOLLATE'
  | 'TEXT_ONLY_MODE';

/** 图形类型枚举 */
type ShapeType = 0 | 1 | 2 | 3 | 4 | 5; // 0-仰角直线 1-俯角直线 2-矩形框线 3-椭圆线 4-实心矩形 5-实心椭圆

/** 数值格式类型枚举 */
type FormatType =
  | `TIME:${string}`
  | 'TIME:FloatValue'
  | 'TIME:IsValidFormat'
  | 'TIME:WeekIndex'
  | `FLOAT:${string}`
  | 'UpperMoney'
  | 'CHAR:FirstPinYin'
  | 'CHAR:IsCharacter'
  | 'CHAR:IsChinese'
  | 'CHAR:EncodeBase64'
  | 'CHAR:DecodeBase64'
  | 'FILE:EncodeBase64'
  | `FILE:DecodeBase64,${string}`
  | 'COLOR:Hex'
  | 'COLOR:Name'
  | 'COLOR:Decimal'
  | `VOICE:${number};${number}`
  | `FILE:WAVE,${string}`;

/** 对话框类型枚举 */
type DialogType = 'LocalFileFullName' | 'Color' | 'LocalFileFullNameForSave' | 'LocalFileFullNameForOpen';

/** 系统信息类型枚举 */
type SystemInfoType =
  | 'Drive.Count'
  | 'Drive.Labels'
  | 'DiskDrive.Count'
  | 'DiskDrive.1.SerialNumber'
  | 'NetworkAdapter.1.PhysicalAddress'
  | 'NetworkAdapter.1.IPAddress'
  | 'BIOS.SerialNumber'
  | 'BaseBoard.SerialNumber'
  | 'GetLastError';

/** 取值类型枚举 */
type ValueType =
  | 'ItemCount'
  | 'ItemTop'
  | 'ItemLeft'
  | 'ItemWidth'
  | 'ItemHeight'
  | 'ItemContent'
  | 'PrintTaskName'
  | 'PRINTED_TIMES'
  | 'PREVIEW_PAGE_NUMBER'
  | 'PRINTSETUP_PAGE_COUNT'
  | 'PRINT_STATUS_TEXT'
  | 'ProgramCodes'
  | 'ProgramData'
  | 'BKIMG_CONTENT';

/** 打印样式名称枚举 */
type PrintStyleName =
  | 'FontName'
  | 'FontSize'
  | 'FontColor'
  | 'Bold'
  | 'Italic'
  | 'Underline'
  | 'Alignment'
  | 'Angle'
  | 'ItemType'
  | 'HOrient'
  | 'VOrient'
  | 'PenWidth'
  | 'PenStyle'
  | 'Stretch'
  | 'PreviewOnly'
  | 'ReadOnly'
  | 'Content'
  | 'QRCodeVersion'
  | 'QRCodeErrorLevel'
  | 'PDF417ErrorLevel'
  | 'DataCharset'
  | 'GroundColor';

/** 增强打印样式名称枚举（包含基础样式） */
type PrintStyleAName =
  | PrintStyleName
  | 'PageIndex'
  | 'PageUnIndex'
  | 'LineSpacing'
  | 'LetterSpacing'
  | 'ItemName'
  | 'StartNumberValue'
  | 'Deleted'
  | 'TransColor'
  | 'AlignJustify'
  | 'TextFrame'
  | 'LinkedItem'
  | 'ChartStyle'
  | 'ShowBarText';

declare global {
  interface Window {
    CLODOP?: LODOP;
    getCLodop: () => LODOP | null;
  }

  /** Lodop 核心对象类型 */
  interface LodopObject {
    // 打印（直接打印）
    PRINT: () => void;
    PRINTA: () => void;
    PRINTB: () => void;
    // 打印预览
    PREVIEW: () => void;
    // 打开打印设计窗口
    PRINT_DESIGN: () => void;
    // 获取打印机数量
    GET_PRINTER_COUNT: () => number;
    // 获取打印机名称
    GET_PRINTER_NAME: (index: number) => string;
    // 设置打印机（通过索引）
    SET_PRINTER_INDEX: (index: number) => void;

    // 初始化
    PRINT_INIT: (title: string) => void;
    // 初始化打印页
    PRINT_INITA: (
      x1: number | string,
      y1: number | string,
      width: number | string,
      height: number | string,
      title: string,
    ) => void;

    // 添加文本
    ADD_PRINT_TEXT: (
      x: number | string,
      y: number | string,
      width: number | string,
      height: number | string,
      text: string,
    ) => void;
    // 添加表格
    ADD_PRINT_TABLE: (
      x: number | string,
      y: number | string,
      width: number | string,
      height: number | string,
      html: string,
    ) => void;

    // 打印HTML模板
    ADD_PRINT_HTM: (
      x: number | string,
      y: number | string,
      width: number | string,
      height: number | string,
      html: string,
    ) => void;
    ADD_PRINT_HTML: (
      x: number | string,
      y: number | string,
      width: number | string,
      height: number | string,
      html: string,
    ) => void;

    // 设置打印样式
    SET_PRINT_STYLEA: (index: number, styleName: string, value: number | string) => void;
    // 设置打印样式（全局）
    SET_PRINT_STYLE: (styleName: string, value: number | string) => void;
    // 打印模型设置
    SET_PRINT_MODE: (model: string, n: number) => void;
  }
  /** LODOP 核心实例类型 */
  interface LODOP {
    // 版本号
    VERSION: string;

    // 一、基本函数
    PRINT_INIT(strTaskName: string): boolean;
    SET_PRINT_PAGESIZE(
      intOrient: PrintOrient,
      PageWidth: number | string,
      PageHeight: number | string,
      strPageName?: string,
    ): void;
    ADD_PRINT_HTM(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strHtmlContent: string,
    ): void;
    ADD_PRINT_TABLE(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strHtml: string,
    ): void;
    ADD_PRINT_URL(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strURL: string,
    ): void;
    ADD_PRINT_TEXT(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strContent: string,
    ): void;
    ADD_PRINT_IMAGE(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strHtmlContent: string,
    ): void;
    ADD_PRINT_RECT(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      intLineStyle: LineStyle,
      intLineWidth: number,
    ): void;
    ADD_PRINT_ELLIPSE(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      intLineStyle: LineStyle,
      intLineWidth: number,
    ): void;
    ADD_PRINT_LINE(
      Top1: number | string,
      Left1: number | string,
      Top2: number | string,
      Left2: number | string,
      intLineStyle: LineStyle,
      intLineWidth: number,
    ): void;
    ADD_PRINT_BARCODE(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      CodeType: BarcodeType,
      CodeValue: string,
    ): void;
    ADD_PRINT_CHART(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      ChartType: ChartType,
      strHtml: string,
    ): void;
    ADD_PRINT_DATA(strDataStyle: 'ProgramData', varDataValue: string): void;
    SET_PRINT_STYLE(strStyleName: PrintStyleName, varStyleValue: any): void;
    PREVIEW(): number | void;
    PRINT(): boolean;
    PRINT_SETUP(): number | void;
    PRINT_DESIGN(): string | void;
    NEWPAGE(): boolean;
    GET_PRINTER_COUNT(): number;
    GET_PRINTER_NAME(strPrinterIDandType: number | string): string;
    SET_PRINTER_INDEX(oIndexOrName: number | string): boolean;
    SELECT_PRINTER(): number;
    SET_SHOW_MODE(strModeType: ShowModeType, varModeValue: any): boolean;
    SET_PRINT_MODE(strModeType: PrintModeType, varModeValue: any): boolean | string;
    SET_PRINT_COPIES(intCopies: number): boolean;
    SET_PREVIEW_WINDOW(
      intDispMode: 0 | 1 | 2,
      intToolMode: 0 | 1 | 2 | 3,
      blDirectPrint: 0 | 1,
      inWidth: number,
      intHeight: number,
      strTitleButtonCaptoin?: string,
    ): void;
    ADD_PRINT_SETUP_BKIMG(strImgHtml: string): void;
    SEND_PRINT_RAWDATA(strRawData: string): boolean;
    WRITE_PORT_DATA(strPortName: string, strData: string): boolean;
    READ_PORT_DATA(strPortName: string): string;
    GET_PRINT_INIFFNAME(strPrintTask: string): string;
    GET_PAGESIZES_LIST(oPrinterName: number | string, strSplit: string): string;
    WRITE_FILE_TEXT(
      intWriteMode: number | string,
      strFileName: string,
      strText: string,
    ): 'ok' | 'file not exist' | 'do nothing';
    GET_FILE_TEXT(strFileName: string): string;
    GET_FILE_TIME(strFileName: string): string;
    IS_FILE_EXIST(strFileName: string): boolean;
    GET_SYSTEM_INFO(strInfoType: SystemInfoType): string | number | null;
    GET_VALUE(ValueType: ValueType, ValueIndex: number | string): any;
    FORMAT(oType: FormatType, oValue: any): any;
    GET_DIALOG_VALUE(oType: DialogType, oPreValue: string): string;

    // 二、增强函数
    PRINT_INITA(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strPrintName: string,
    ): boolean;
    ADD_PRINT_HTML(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strHtmlContent: string,
    ): void;
    ADD_PRINT_TBURL(
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strURL: string,
    ): void;
    ADD_PRINT_TEXTA(
      strItemName: string,
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      strContent: string,
    ): void;
    SET_PRINT_STYLEA(varItemNameID: number | string, strStyleName: PrintStyleAName, varStyleValue: any): void;
    SAVE_TO_FILE(strFileName: string): boolean;
    SET_SAVE_MODE(varModeName: string, varModeValue: any): boolean;
    ADD_PRINT_SHAPE(
      intShapeType: ShapeType,
      Top: number | string,
      Left: number | string,
      Width: number | string,
      Height: number | string,
      intLineStyle: LineStyle,
      intLineWidth: number,
      varColor: string | number,
    ): void;
    SET_PRINTER_INDEXA(oIndexOrName: number | string): boolean;
    NEWPAGEA(): boolean;
    PREVIEWA(): number | void;
    PREVIEWB(): number | void;
    PRINTA(): boolean;
    PRINTB(): boolean;
    SHOW_CHART(): void;
    DO_ACTION(ActName: string, ActValue: any): void;
    SET_LICENSES(strCompanyName: string, strLicense: string, strLicenseA: string, strLicenseB: string): void;
  }
}

export {};

// // 全局变量声明（用于页面调用）
// declare var LODOP: LODOP;

// // 获取 LODOP 实例的函数类型
// declare function getLodop(oOBJECT?: HTMLElement, oEMBED?: HTMLElement): LODOP;
