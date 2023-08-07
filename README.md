# BingNUOS Admin Panel

BingNUOS Admin Panel Flutter project.

The admin panel of BingNUOS is a web-based interface developed using Flutter and hosted on Firebase Hosting. It is designed for administrators and moderators to manage schedules, groups, and user data for the scheduling system.

The interface includes a table with columns for schedule times and rows for each group. Each cell in the table displays the schedule for the corresponding group and time. The top of the page includes a drop-down menu for selecting language between English/Ukrainan/Russian and a theme switch for light/dark/auto mode.

The admin panel includes two types of users: administrators and moderators. Administrators have the ability to manage moderators, register user emails, and manage moderation groups. The panel also allows administrators to add, view, and modify group and schedule data. Moderators are assigned to specific moderation groups and can manage only the schedules and groups assigned to them.

The admin panel is connected to the Firebase database, which enables real-time updates of schedules in the [Telegram bot](https://github.com/shebnik/BingNUOS-Telegram) whenever changes are made in the panel. This feature ensures that schedules are always up-to-date and that users receive the correct information in real-time.

Overall, the BingNUOS admin panel is a powerful tool for managing the scheduling system for university students. Its user-friendly interface and real-time synchronization capabilities make it an essential component of the BingNUOS system.

# Related
[Telegram bot GitHub project](https://github.com/shebnik/BingNUOS-Telegram)

# Screenshots

Login Page
![auth](https://user-images.githubusercontent.com/52208650/219057640-1f1551be-b38e-49c5-a9cd-1b233d3a0590.png)

Timetable
![timetable](https://user-images.githubusercontent.com/52208650/219059280-89b1a54b-82da-4afa-94df-3c31a0d76b36.png)

Manage Schedule
![image](https://user-images.githubusercontent.com/52208650/219060905-b5e64d0d-44bb-4649-a04e-cffcd48fb0be.png)

Tutorial
![image](https://user-images.githubusercontent.com/52208650/219059511-99a5ac74-58cf-46ad-8d06-2295672e891c.png)
