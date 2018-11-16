# p4vmappinggen

Generate Perforce workspace mapping from JSON.

## Usase

```
$ ruby p4vmappinggen -i input.json > output.txt
```

## Input JSON example

```json
{
    "workspace-root": "//MyWorkspace",
    "depot-root": "//root/projects",
    "mappings": {
        "includes": [
            "foo/...",
            "bar/*"
        ],
        "excludes": [
            "foo/.../build/...",
            "bar/*.cannot-open"
        ]
    }
}
```