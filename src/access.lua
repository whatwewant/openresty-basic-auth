local getenv = os.getenv

local function get_token()
  local authorization = ngx.req.get_headers()['authorization']
  local matched = ngx.re.match(authorization, 'Bearer (.*)', 'jo')

  if matched == nil then
    return nil
  end

  local token = matched[1]
  if token == nil then
    return nil
  end

  return token
end

local function validate_token(token)
  if token == nil then
    return false
  end

  if token ~= getenv('BEARER_TOKEN') then
    return false
  end

  return true
end

local function check()
  local token = get_token()
  local is_valid = validate_token(token)

  if is_valid == false then
    return ngx.exit(ngx.HTTP_UNAUTHORIZED) 
  end
end

check()