#!/bin/bash
# sudo pacman -S --needed base-devel git stow
# mkdir ~/Git
# cd ~/Git
# git clone https://aur.archlinux.org/paru.git
# cd paru
# makepkg -si
#
# set -eo pipefail
#
# # 颜色定义
# RED='\033[0;31m'
# GREEN='\033[0;32m'
# YELLOW='\033[0;33m'
# NC='\033[0m' # 重置颜色
#
# # 帮助信息
# show_help() {
#     echo -e "使用方法: $0 [选项] <软件列表文件>"
#     echo -e "选项:"
#     echo -e "  -h, --help    显示帮助信息"
#     echo -e "  -y, --yes     自动确认安装"
#     echo -e "  -d, --dry-run 模拟运行（不实际安装）"
#     exit 0
# }
#
# # 初始化变量
# AUTO_CONFIRM=0
# DRY_RUN=0
# PACKAGE_FILE=""
#
# # 解析参数
# while [[ $# -gt 0 ]]; do
#     case "$1" in
#         -h|--help)
#             show_help
#             ;;
#         -y|--yes)
#             AUTO_CONFIRM=1
#             shift
#             ;;
#         -d|--dry-run)
#             DRY_RUN=1
#             shift
#             ;;
#         *)
#             if [[ -f "$1" ]]; then
#                 PACKAGE_FILE="$1"
#                 shift
#             else
#                 echo -e "${RED}错误: 无效参数或文件不存在: $1${NC}" >&2
#                 exit 1
#             fi
#             ;;
#     esac
# done
#
# # 验证文件参数
# if [[ -z "$PACKAGE_FILE" ]]; then
#     echo -e "${RED}错误: 必须指定软件列表文件${NC}" >&2
#     show_help
#     exit 1
# fi
#
# # 检测包管理器
# detect_pkg_manager() {
#     if command -v apt-get &> /dev/null; then
#         PKG_MANAGER="apt-get"
#         UPDATE_CMD="sudo apt-get update -y"
#         INSTALL_CMD="sudo apt-get install -y"
#     elif command -v dnf &> /dev/null; then
#         PKG_MANAGER="dnf"
#         UPDATE_CMD="sudo dnf check-update -y"
#         INSTALL_CMD="sudo dnf install -y"
#     elif command -v yum &> /dev/null; then
#         PKG_MANAGER="yum"
#         UPDATE_CMD="sudo yum check-update -y"
#         INSTALL_CMD="sudo yum install -y"
#     elif command -v paru &> /dev/null; then
#         PKG_MANAGER="paru"
#         UPDATE_CMD="sudo paru -Sy"
#         INSTALL_CMD="sudo paru -S --noconfirm"
#     elif command -v brew &> /dev/null; then
#         PKG_MANAGER="brew"
#         UPDATE_CMD="brew update"
#         INSTALL_CMD="brew install"
#     else
#         echo -e "${RED}错误: 未检测到支持的包管理器${NC}" >&2
#         exit 1
#     fi
# }
#
# # 用户确认
# confirm_installation() {
#     if [[ $AUTO_CONFIRM -eq 1 ]]; then
#         return 0
#     fi
#
#     echo -e "${YELLOW}即将安装以下软件包 (共 ${#PACKAGES[@]} 个):${NC}"
#     printf '  %s\n' "${PACKAGES[@]}"
#     echo
#
#     read -rp "确认安装？[y/N] " answer
#     if [[ ! "$answer" =~ ^[Yy] ]]; then
#         echo -e "${RED}安装已取消${NC}"
#         exit 0
#     fi
# }
#
# # 安装软件包
# install_packages() {
#     echo -e "${GREEN}检测到包管理器: ${PKG_MANAGER}${NC}"
#
#     # 更新软件源
#     echo -e "\n${YELLOW}正在更新软件源...${NC}"
#     if [[ $DRY_RUN -eq 1 ]]; then
#         echo "[DRY RUN] ${UPDATE_CMD}"
#     else
#         eval "${UPDATE_CMD}" || {
#             echo -e "${RED}更新软件源失败，继续尝试安装...${NC}"
#         }
#     fi
#
#     # 安装每个软件包
#     local success=()
#     local failed=()
#
#     for pkg in "${PACKAGES[@]}"; do
#         echo -e "\n${YELLOW}正在安装: ${pkg}${NC}"
#
#         if [[ $DRY_RUN -eq 1 ]]; then
#             echo "[DRY RUN] ${INSTALL_CMD} ${pkg}"
#             success+=("$pkg")
#             continue
#         fi
#
#         if eval "${INSTALL_CMD} ${pkg}"; then
#             echo -e "${GREEN}安装成功: ${pkg}${NC}"
#             success+=("$pkg")
#         else
#             echo -e "${RED}安装失败: ${pkg}${NC}" >&2
#             failed+=("$pkg")
#         fi
#     done
#
#     # 显示结果统计
#     echo -e "\n${GREEN}安装完成!${NC}"
#     echo -e "成功: ${#success[@]} 个"
#     echo -e "失败: ${#failed[@]} 个"
#
#     if [[ ${#failed[@]} -gt 0 ]]; then
#         echo -e "\n${RED}失败的软件包:${NC}"
#         printf '  %s\n' "${failed[@]}"
#         exit 1
#     fi
# }
#
# # 主流程
# main() {
#     # 检测包管理器
#     detect_pkg_manager
#
#     # 读取软件列表文件
#     mapfile -t PACKAGES < <(
#         grep -vE '^#|^$' "$PACKAGE_FILE" | sed 's/#.*//' | tr -d '\r'
#     )
#
#     if [[ ${#PACKAGES[@]} -eq 0 ]]; then
#         echo -e "${YELLOW}没有需要安装的软件包${NC}"
#         exit 0
#     fi
#
#     # 确认安装
#     confirm_installation
#
#     # 执行安装
#     install_packages
# }
#
# # 执行主函数
# main
while IFS= read -r line; do
  stow "$line"
done < stow.txt
makoctl reload
