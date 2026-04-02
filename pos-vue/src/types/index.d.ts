import type { ElPagination, TableInstance, FormInstance, ButtonInstance } from 'element-plus';
declare global {
  type ButtonType = ButtonInstance['type'];
  type ElTableProps = TableInstance['$props'];
  type ElFormInstance = FormInstance;

  /** 所有 api 接口的响应数据都应该准守该格式 */
  interface ApiResponseData<T> {
    code: number;
    data: T;
    message: string;
  }

  // element 类型问题，去掉只读属性限制
  interface ElPaginationProps
    extends Omit<InstanceType<typeof ElPagination>['$props'], 'currentPage' | 'pageSize' | 'total'> {
    currentPage?: number;
    pageSize?: number;
    total?: number;
  }
  interface OptionItem {
    value: string | number;
    label: string;
    // [key: string]: any;
  }
  interface TreeDataItem {
    label: string; //	树节点显示的内容	string|slot	'---'
    value?: string; //	树节点显示的内容	string|slot	'---'
    disabled?: boolean; //是否禁用	boolean	false
    isLeaf?: boolean; //	是否是叶子节点	boolean	false 叶子节点就是有展开框
    children?: TreeDataItem[];
  }

  interface CommonPageListParam {
    page?: number; // 当前页码
    limit?: number; // 当前页码
  }
  interface PageInfo extends CommonPageListParam {
    total: number; //	总条目数
    page: number; //	当前页码
    limit: number; //	每页条数
  }
  // 分页列表参数 可以扩展额外参数
  type PageListParam<OtherParam = unknown> = CommonPageListParam & {
    [P in keyof OtherParam]: OtherParam[P];
  };

  // 分页列表接口返回值
  interface PageListInfo<List = unknown> {
    pageNo: number; // 当前页码
    pageSize: number; // 每页多少个
    records: List[];
    totalCount: number;
  }
  // 分页列表接口返回值
  interface PageListInfo<List = unknown> {
    rows: List[];
    total: number;
  }

  // 应用中心列表，标准接口返回值
  interface AppDataItem {
    icon?: string; // 应用图标
    name?: string; // 名称
    url?: string; // 应用链接
    children?: AppDataItem[];
  }

  // 应用单个数据，将分类名称、应用数据都转为数组下内容
  interface AppDataCell {
    icon?: string; // 应用图标
    name?: string; // 名称
    url?: string; // 应用链接
    type?: string; // 分类，【title 标题】【app 应用实体】
  }

  type DialogType = 'add' | 'view' | 'edit';
}
