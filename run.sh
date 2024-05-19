
# 复制相关文档到带上传文件夹
rm -rf content/posts/copyMD
mkdir content/posts/copyMD
cp -rf ../copyMD/* ./content/posts/copyMD

# 清除原有静态文件
rm -rf public/*

# 生成静态页面
mkdir public
hugo


# 复制google的验证文件
cp google020baa8b42db4f8b.html ./public/google020baa8b42db4f8b.html


# 进入静态文件夹
cd public

# 创建CNAME, DNS重定向
touch CNAME
# echo "blog.kenger.work" > CNAME


# 初始化
git init

# 设置账号
git config user.name "name"
git config user.email "email"

# commit
git add .
git commit -m "$(date) Update from Action"

# 本地切换分支
git branch gh-pages 
git checkout gh-pages 

# 强制上传
git push --force --quiet "https://kengerlwl:${GITHUB_TOKEN}@github.com/kengerlwl/kengerlwl.github.io.git"  gh-pages    

