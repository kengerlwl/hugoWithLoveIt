#!/bin/bash

# 备份原始文件
cp index.html index.html.bak

# 要注入的CSS样式
CSS_CONTENT=$(cat <<'EOF'
    /* 浮动按钮样式 - 自动添加 */
    .float-btn {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: #2196F3;
        color: white;
        border: none;
        cursor: pointer;
        box-shadow: 0 2px 5px rgba(0,0,0,0.3);
        transition: 0.3s;
    }
    .float-btn:hover {
        background: #1976D2;
        transform: scale(1.1);
    }
    /* 模态框样式 - 自动添加 */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 1000;
    }
    .modal-content {
        position: relative;
        background: white;
        margin: 5% auto;
        padding: 20px;
        width: 80%;
        height: 80%;
        border-radius: 8px;
    }
    /* iframe样式 - 自动添加 */
    #embedded-iframe {
        width: 100%;
        height: 100%;
        border: none;
        border-radius: 4px;
    }
    /* 关闭按钮 - 自动添加 */
    .close-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        background: #ff4444;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
    }
EOF
)

# 要注入的HTML结构
HTML_CONTENT=$(cat <<'EOF'
    <!-- 自动添加的浮动按钮 -->
    <button class="float-btn" onclick="openModal()">打开</button>
    
    <!-- 自动添加的模态框 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <button class="close-btn" onclick="closeModal()">关闭</button>
            <iframe id="embedded-iframe" src="http://127.0.0.1:5000/"></iframe>
        </div>
    </div>
EOF
)

# 要注入的JavaScript代码
JS_CONTENT=$(cat <<'EOF'
    <!-- 自动添加的脚本 -->
    <script>
        // 打开模态框
        function openModal() {
            document.getElementById('myModal').style.display = 'block';
        }

        // 关闭模态框
        function closeModal() {
            document.getElementById('myModal').style.display = 'none';
        }

        // 点击模态框外部关闭
        window.onclick = function(event) {
            const modal = document.getElementById('myModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
EOF
)

# 使用sed命令注入代码
sed -i "/<\/head>/i\ \n$CSS_CONTENT\n" index.html
sed -i "/<\/body>/i\ \n$HTML_CONTENT\n" index.html
sed -i "/<\/body>/i\ \n$JS_CONTENT\n" index.html

echo "悬浮框功能已成功添加到index.html"
echo "原始文件已备份为index.html.bak"