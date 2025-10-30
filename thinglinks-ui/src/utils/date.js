// 在 utils 目录下创建 date.js
// src/utils/date.js
export function formatDateTime(date, format = 'yyyy-MM-dd HH:mm:ss') {
  if (!date) return ''

  const d = new Date(date)
  const map = {
    'yyyy': d.getFullYear(),
    'MM': String(d.getMonth() + 1).padStart(2, '0'),
    'dd': String(d.getDate()).padStart(2, '0'),
    'HH': String(d.getHours()).padStart(2, '0'),
    'mm': String(d.getMinutes()).padStart(2, '0'),
    'ss': String(d.getSeconds()).padStart(2, '0')
  }

  return format.replace(/yyyy|MM|dd|HH|mm|ss/g, matched => map[matched])
}
