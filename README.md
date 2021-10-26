После добавления файлоа .gitignore , будут проигнорированы файлы/каталоги:
1.Директория /.terraform/
2.Файлы c расширениями tfstate,tfvars
3.лог файлы crash.log
4.файлы :
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc
terraform.rc


