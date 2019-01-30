
#!/bin/bash(建立.sh时自动生成)


# AppleID
username="1033553441@qq.com"
# 密码
password="Iphone5spassword"
# target名称
scheme="AutoArchive"
# 项目名
project_name="AutoArchive"
# 此处为相对路径
workspace="../${project_name}.xcworkspace"
# 打包类型
config="Release"
# 支持的sdk
sdk="iphoneos"
# xcarchive文件路径
xcarchive="xcarchive"
archive_path="${xcarchive}/${scheme}.xcarchive"
# ipa文件路径
ipa_path="ipa"
# 打包配置文件路径
plist_path="ExportOptions_Appstore.plist"


# ）清除旧文件
echo "清除旧文件"
rm -rf "${xcarchive}"
rm -rf "${ipa_path}"

# ）清理项目
xcodebuild clean -workspace "$workspace" -scheme "$scheme" -configuration "$config"
# ）打包
xcodebuild archive -workspace "$workspace" -scheme "$scheme" -configuration "$config" -sdk "$sdk" -archivePath "$archive_path"

# xcarchive 实际是一个文件夹不是一个文件所以使用 -d 判断
if [ -d "$archive_path" ]
then
echo "构建成功......"
else
echo "构建失败......"
exit 1
fi

# ）导出ipa
xcodebuild -exportArchive -archivePath "$archive_path" -exportPath "$ipa_path" -exportOptionsPlist "$plist_path" -allowProvisioningUpdates

if [ -f "$ipa_path/${scheme}.ipa" ]
then
    echo "导出ipa成功......"
else
    echo "导出ipa失败......"
    exit 1
fi

# ）上传App Store
# Application Loader路径
altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
# 判断
"${altoolPath}" --validate-app -f "$ipa_path/${scheme}.ipa" -u "$username" -p "$password" --output-format xml
# 上传
"${altoolPath}" --upload-app -f "$ipa_path/${scheme}.ipa" -u "$username" -p "$password" --output-format xml

if [ $? = 0 ]
then
    echo "~~~~~~~~~~~~~~~~上传成功~~~~~~~~~~~~~~~~~~~"

    # ）上传成功后清除文件
    echo "清除文件"
    rm -rf "${xcarchive}"
    rm -rf "${ipa_path}"

else
    echo "~~~~~~~~~~~~~~~~上传失败~~~~~~~~~~~~~~~~~~~"
fi
