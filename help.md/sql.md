# mysql

## 安装 SQL

[如何在 Ubuntu 20.04 上安装 MySQL](https://zhuanlan.zhihu.com/p/137339787)
[Mysql添加用户](https://blog.csdn.net/qq_39331713/article/details/81747188)

```bash
sudo apt update
sudo apt install mysql-server
```

在`MySQL 8.0`上，`root` 用户默认通过`auth_socket`插件授权。
`auth_socket`插件通过 `Unix socket` 文件来验证所有连接到`localhost`的用户。这意味着你不能通过提供密码，验证为`root`。
以 `root` 用户身份登录 `MySQL` 服务器，输入；

```bash
sudo mysql
```

如果你想以 `root` 身份登录 `MySQL` 服务器，使用其他的程序，例如 `phpMyAdmin`，你有两个选择。

第一个就是将验证方法从`auth_socket`修改成`mysql_native_password`。你可以通过运行下面的命令实现：

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '密码';
FLUSH PRIVILEGES;
```

第二个选项，推荐的选项，就是创建一个新的独立管理用户，拥有所有数据库的访问权限：

```sql
GRANT ALL ON *.* TO 'administrator'@'localhost' IDENTIFIED BY '密码';
```

### 创建用户

```sql
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
```

`username` -你将创建的用户名说明:
`host` – 指定该用户在哪个主机上可以登陆,如果是本地用户可用`localhost`,  如 果想让该用户可以从任意远程主机登陆,可以使用通配符`%`
`password` –  该用户的登陆密码,密码可以为空,如果为空则该用户可以不需要密码登 陆服务器

例子：

```sql
CREATE USER 'javacui'@'localhost' IDENTIFIED BY '123456'; 
CREATE USER 'javacui'@'172.20.0.0/255.255.0.0' IDENDIFIED BY '123456'; 
CREATE USER 'javacui'@'%' IDENTIFIED BY '123456'; 
```

### 授权

```sql
GRANT privileges ON databasename.tablename TO 'username'@'host';
```

+ `privileges` – 用户的操作权限,如 `SELECT` , `INSERT` , `UPDATE`  等(详细列表见该文最后面).如果要授予所有的权限则使用`ALL`说明: 
+ `databasename` –  数据库名
+ `tablename`-表名,如果要授予该用户对所有数据库和表的相应操作权限则可用`*` 表示, 如`*.*`

例子:

```sql
GRANT SELECT, INSERT ON test.user TO 'javacui'@'%'; 
GRANT ALL ON *.* TO 'javacui'@'%';
```

```sql
GRANT All ON *.* TO 'tom'@'%' IDENTIFIED BY '9512';
```

注意:用以上命令授权的用户不能给其它用户授权,如果想让该用户可以授权,用以下命令

```sql
GRANT privileges ON databasename.tablename TO 'username'@'host' WITH GRANT OPTION;
```

### 设置与更改用户密码

```sql
SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');
/* 如果是当前登陆用户用  */
SET PASSWORD = PASSWORD("newpassword");
```

### 撤销用户权限

```sql
REVOKE privilege ON databasename.tablename FROM 'username'@'host';
```

`privilege`, `databasename`, `tablename` – 同授权部分

假如你在给用户`'javacui'@'%'`授权的时候是这样的:

```sql
GRANT SELECT ON test.user TO 'javacui'@'%';
```

则在使用`REVOKE SELECT ON *.* FROM 'javacui'@'%';`命令并不能撤销该用户对`test`数据库中`user`表的`SELECT`操作.

相反,如果授权使用的是

```sql
GRANT SELECT ON  *.* TO 'javacui'@'%';
```

则`REVOKE SELECT ON test.user FROM  'javacui'@'%';`命令也不能撤销该用户对`test`数据库中`user`表的 `Select` 权限
具体信息可以用命令`SHOW GRANTS FOR 'javacui'@'%';`查看

### 删除用户

```sql
DROP USER 'username'@'host';
```

操作后切记刷新数据库

```sql
flush privileges;
```
