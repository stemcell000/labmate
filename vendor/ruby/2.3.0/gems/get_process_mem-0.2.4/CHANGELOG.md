## 0.2.4

- Use FFI to speed up memory lookup on Mac (darwin) by roughly 12x (#32)

## 0.2.3

- Silence BigDecimal deprecation warning under Ruby 2.5 (#26)

## 0.2.2

- Fix support for Ruby 2.4 (#23)

## 0.2.1

- ???

## 0.2.0

- Reverting back to RSS for linux until (#7) is resolved

## 0.1.1

- Bugfix: the `ps` style of memory reporting should always use RSS, and Linux should always use PSS

## 0.1.0

- Default to using PSS for linux (#2 & #3) @ksoderstrom
- Correct for bit shifting truncation (#4) @ksoderstrom

## 0.0.1

- Initial
