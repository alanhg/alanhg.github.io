---
title: Antd使用中的需注意的细节
tags:
  - Antd
  - 源码
abbrlink: 4b39af4f
date: 2020-02-20 22:49:56
---

## Table-column中的key

假如配置了dataIndex,key可以不写，因为key如果为undefined时，会去取dataIndex。

以下为antd部分源码

```typescript
columns = columns.map((column, i) => {
      const newColumn = { ...column };
      newColumn.key = this.getColumnKey(newColumn, i);
      return newColumn;
    });
```
```typescript
 getColumnKey(column: ColumnProps<T>, index?: number) {
    return column.key || column.dataIndex || index;
  }
```
##  Table-rowKey
假如rowKey不指定，则`默认为rowIndex`。所以假如记录确实没有任何唯一的字段，不指定。

```typescript
 getRecordKey = (record: T, index: number) => {
    const { rowKey } = this.props;
    const recordKey =
      typeof rowKey === 'function' ? rowKey(record, index) : (record as any)[rowKey!];
    warning(
      recordKey !== undefined,
      'Table',
      'Each record in dataSource of table should have a unique `key` prop, ' +
        'or set `rowKey` of Table to an unique primary key, ' +
        'see https://u.ant.design/table-row-key',
    );
    return recordKey === undefined ? index : recordKey;
  };
```


##  Table-列render中的三个参数

antd官方文档对于render的描述是这样的

```typescript
Function(text, record, index) {}	
```
我们习惯实现时也声明为这样的三参函数，但是实际上一定要这样吗？不是的。

比如，列没有配置dataIndex，在实际的render中，我们可以这样

```typescript
 render: (record) => this.props.isHidden? record.a : record.b)
```

antd的UI组件都是封装了RC组件库，更多只是修改了UI，column渲染逻辑主要在rc-table的源码中。

源码中逻辑是这样的，在获取列单元格render函数的第一个参数值的时候，会先用dataIndex去拿，假如dataIndex不存在且不是number基本类型时，会返回当前行记录。

`结论，dataIndex不存在且不是number类型时间，render单元格render真正执行时，第一个参value就会是record。但index一定是第三个参数`

src/Cell/index.tsx

```typescript
  const value = getPathValue<object | React.ReactNode, RecordType>(record, dataIndex);
```
src/utils/valueUtil.tsx

```typescript
export function getPathValue<ValueType, ObjectType extends object>(
  record: ObjectType,
  path: DataIndex,
): ValueType {
  // Skip if path is empty
  if (!path && typeof path !== 'number') {
    return (record as unknown) as ValueType;
  }

  const pathList = toArray(path);

  let current: ValueType | ObjectType = record;

  for (let i = 0; i < pathList.length; i += 1) {
    if (!current) {
      return null;
    }

    const prop = pathList[i];
    current = current[prop];
  }

  return current as ValueType;
}
```

## TreeSelect-TreeNode中value的唯一性
当我们构造TreeNode数据时，要注意`value必须唯一`,重复value带来的直接问题是显示出错，因为同value对应的nodeTitle不同，组件会显示后者。

假如实际数据确实会有value相同，那就分析差异性，比如增加固定前后缀等，构建两者的不同。

当出现了重复value时，会有warning提示，so发现这个情况一定要处理。

![](https://i.imgur.com/4VczqoW.png)


## Form中的validator

validaor中，return true or false用于标记校验是否通过，对于报错信息取决于callback(new Error()),但是注意到`假如validator执行报错，异常信息是不会被程序捕捉到的。表现出来的现象就是 form.validate一直block，程序不会继续向下走。
控制台也不会有任何的提示信息。`


