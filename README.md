# p4vmappinggen

Generate Perforce workspace mapping from JSON.

## Usase

```
$ ruby p4vmappinggen -i input.json > output.txt
```

## Input JSON example

```json
{
    "workspace-root": "/Volumes/source/p4source",
    "depot-root": "//",
    "mappings": {
        "includes": [
            "root/projects/foo/...",
            "root/projects/bar/*"
        ],
        "excludes": [
            "root/projects/foo/.../build/...",
            "root/projects/bar/*.cannot-open"
        ]
    }
}
```