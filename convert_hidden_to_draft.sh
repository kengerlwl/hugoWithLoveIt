#!/bin/bash

# 指定文章目录
ARTICLE_DIR="content"

# 使用 find 命令查找所有的 Markdown 文件，并处理它们
find "$ARTICLE_DIR" -type f -name "*.md" -exec bash -c '
    for file; do
        # 提取文件名（不含扩展名）
        filename=$(basename "$file" .md)
        # 检查文件中是否存在 hidden 参数
        grep -q "^hidden:" "$file"
        if [ $? -eq 0 ]; then
            # 如果存在 hidden 参数，则将其替换为 draft
            sed -i "s/^hidden:/draft:/" "$file"
            echo "Converted $filename from hidden to draft"
        else
            echo "No hidden parameter found in $filename"
        fi
    done
' bash {} +
