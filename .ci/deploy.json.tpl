{
    "package": {
        "name": $PKG,
        "repo": "bottles-ngdevkit",
        "subject": "dciabrin",
        "vcs_url": $VCS,
        "licenses": ["GPL-3.0"],
        "public_download_numbers": true,
        "public_stats": true
    },

    "version": {
        "name": $VERSION,
        "desc": $DESC,
        "released": $DATE
    },

    "files": [{"includePattern": $PATTERN, "uploadPattern": "/$2-$3",
               "matrixParams": {"override": 1}
              }],
    "publish": false
}
