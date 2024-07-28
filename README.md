# Bond CLI

Bond CLI is a command-line tool for streamlining Flutter Bond app development.

## Installation

```bash
dart pub global activate bond_cli
```

---

## Local Development

To activate the Bond CLI for local development, run the following command:

```bash
dart pub global activate --source="path" . --executable="bond" --overwrite
```

**Important**: After each update to the code, you may need to delete the cached snapshot of the Bond CLI to ensure your changes are reflected. 

To delete the cached snapshot, navigate to the following path and remove the snapshot files:

```bash
.dart_tool/pub/bin/bond_cli/*.snapshot
```

This step ensures that your code changes are recognized during development.
