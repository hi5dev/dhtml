# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog], and this project adheres to [Semantic Versioning].

## [Unreleased]

## [0.1.5] - 2021-05-11
### Removed
- Bytes written is no longer returned since `StringIO` is not fully implemented by Opal.

## [0.1.4] - 2021-05-11
### Added
- `pretty_html` method that formats the document in a way presentable to a human.

### Fixed
- `write_html_tag` and `write_html_element` return the number of bytes written.

## [0.1.3] - 2021-05-10
- Initial release
- Versions prior to this were yanked. The gems were packaged with absolute paths by mistake.

[Unreleased]: https://github.com/hi5dev/dhtml/compare/v0.1.4...HEAD
[0.1.5]: https://github.com/hi5dev/dhtml/compare/v0.1.4..v0.1.5
[0.1.4]: https://github.com/hi5dev/dhtml/compare/v0.1.3..v0.1.4
[0.1.3]: https://github.com/hi5dev/dhtml/releases/tag/v0.1.3

[Keep a Changelog]: https://keepachangelog.com/en/1.0.0/
[Semantic Versioning]: https://semver.org/spec/v2.0.0.html
