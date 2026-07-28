let prelude = ''
class CodecError(ValueError):
    def __init__(self, operation: str, path: str, message: str):
        super().__init__(f"{operation} error at {path}: {message}")
        self.operation = operation
        self.path = path
        self.message = message


def _fail(operation: str, path: str, message: str) -> None:
    raise CodecError(operation, path, message)


def _field(path: str, name: str) -> str:
    return f"{path}.{name}"


def _index(path: str, index: int) -> str:
    return f"{path}[{index}]"


def _object(operation: str, value: Any, path: str) -> dict[str, Any]:
    if not isinstance(value, dict) or any(not isinstance(key, str) for key in value):
        _fail(operation, path, "expected object")
    return value


def _array(operation: str, value: Any, path: str) -> list[Any]:
    if not isinstance(value, list):
        _fail(operation, path, "expected array")
    return value


def _string(operation: str, value: Any, path: str) -> str:
    if not isinstance(value, str):
        _fail(operation, path, "expected string")
    return value


def _number(operation: str, value: Any, path: str, kind: str) -> int | float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        _fail(operation, path, "expected number")
    if not math.isfinite(value):
        _fail(operation, path, "expected finite number")
    if kind in ("natural", "integer") and not isinstance(value, int):
        _fail(operation, path, "expected integer")
    if kind == "natural" and value < 0:
        _fail(operation, path, "expected natural number")
    return value


def _text(operation: str, value: Any, path: str, variant: str) -> str:
    value = _string(operation, value, path)
    if variant == "none":
        return value
    if variant == "email" and re.fullmatch(r"[^@\s]+@[^@\s]+\.[^@\s]+", value):
        return value
    if variant == "url":
        parsed = urlparse(value)
        if parsed.scheme and parsed.netloc:
            return value
    if variant == "base64":
        try:
            base64.b64decode(value, validate=True)
            return value
        except ValueError:
            pass
    if variant == "base64url":
        try:
            if re.fullmatch(r"[A-Za-z0-9_-]*={0,2}", value):
                base64.b64decode(value, altchars=b"-_", validate=True)
                return value
        except ValueError:
            pass
    if variant == "e164" and re.fullmatch(r"\+[1-9][0-9]{1,14}", value):
        return value
    if variant == "ipv4":
        try:
            if isinstance(ip_address(value), IPv4Address):
                return value
        except ValueError:
            pass
    if variant == "ipv6":
        try:
            if isinstance(ip_address(value), IPv6Address):
                return value
        except ValueError:
            pass
    if variant == "isoDate":
        try:
            date.fromisoformat(value)
            return value
        except ValueError:
            pass
    if variant == "isoDateTime":
        try:
            datetime.fromisoformat(value.replace("Z", "+00:00"))
            return value
        except ValueError:
            pass
    if variant == "isoTime":
        try:
            time.fromisoformat(value)
            return value
        except ValueError:
            pass
    if variant == "isoDuration" and re.fullmatch(r"P(?=\d|T\d)(?:\d+Y)?(?:\d+M)?(?:\d+W)?(?:\d+D)?(?:T(?:\d+H)?(?:\d+M)?(?:\d+(?:\.\d+)?S)?)?", value):
        return value
    if variant == "uuid":
        try:
            UUID(value)
            return value
        except ValueError:
            pass
    if variant.startswith("literal:") and value == variant[8:]:
        return value
    _fail(operation, path, f"invalid {variant} text")


def _any(operation: str, value: Any, path: str) -> Any:
    if value is None or isinstance(value, (bool, str)):
        return value
    if isinstance(value, (int, float)) and not isinstance(value, bool):
        return _number(operation, value, path, "none")
    if isinstance(value, list):
        for index, item in enumerate(value):
            _any(operation, item, _index(path, index))
        return value
    if isinstance(value, dict) and all(isinstance(key, str) for key in value):
        for key, item in value.items():
            _any(operation, item, _field(path, key))
        return value
    _fail(operation, path, "expected JSON value")


def _time(operation: str, value: Any, path: str, variant: str) -> Any:
    if variant == "none":
        if operation == "encode":
            if not isinstance(value, datetime): _fail(operation, path, "expected datetime")
            return value.isoformat()
        try:
            return datetime.fromisoformat(_string(operation, value, path).replace("Z", "+00:00"))
        except ValueError:
            _fail(operation, path, "expected ISO date-time")
    if variant == "date":
        if operation == "encode":
            if not isinstance(value, date) or isinstance(value, datetime): _fail(operation, path, "expected date")
            return value.isoformat()
        try:
            return date.fromisoformat(_string(operation, value, path))
        except ValueError:
            _fail(operation, path, "expected ISO date")
    if variant == "time":
        if operation == "encode":
            if not isinstance(value, time): _fail(operation, path, "expected time")
            return value.isoformat()
        try:
            return time.fromisoformat(_string(operation, value, path))
        except ValueError:
            _fail(operation, path, "expected ISO time")
    return _text(operation, value, path, "isoDuration")
''

in  prelude
