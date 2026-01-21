// 扩展 Array 接口（重载定义）
declare global {
  interface Array<T> {
    treeMap<U>(callback: (item: T) => U, childrenKey?: string): U[];
  }
}

// 实现原型方法（重载实现）
Array.prototype.treeMap = function <T, U>(this: T[], callback: (item: T) => U, childrenKey: string = 'children'): U[] {
  return this.reduce((result: U[], current: T) => {
    const item = callback(current);
    if (item) {
      result.push(item);
    }

    // 通过指定的字段名获取子节点
    const currentItem = current as unknown as Record<string, any>;
    const childNodes = currentItem[childrenKey];

    if (Array.isArray(childNodes) && childNodes.length > 0) {
      result.push(...childNodes.treeMap(callback, childrenKey));
    }

    return result;
  }, []);
};

export {};
