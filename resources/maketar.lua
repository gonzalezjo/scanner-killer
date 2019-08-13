local HEADERS_TO_GENERATE = 1e5
local ffi = require('ffi')
ffi.cdef('void *malloc(size_t size);')
do
  local header, header_s
  do
    local file = io.open('archive_nonull', 'rb')
    header = file:read('*a')
    header_s = #header
    file:close()
  end
  do
    local new_header = ffi.new('char[?]', header_s)
    ffi.copy(new_header, header)
    header = new_header
  end
  local buf = ffi.C.malloc(header_s * HEADERS_TO_GENERATE)
  buf = ffi.cast('char*', buf)
  for i = 0, HEADERS_TO_GENERATE - 1 do
    for j = 0, header_s - 1 do
      buf[(header_s * i) + j] = header[j]
    end
  end
  do
    local file = io.open('output100mb', 'wb')
    file:write(ffi.string(buf, HEADERS_TO_GENERATE * header_s))
    print(HEADERS_TO_GENERATE * header_s)
    file:close()
    return file
  end
end
