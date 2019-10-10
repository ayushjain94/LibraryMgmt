This README would normally document whatever steps are necessary to get the application up and running.

Admin creds: username: ajain37@ncsu.edu password: 123456

Points to be noted:

Facebook login - Only for student - Default Education level (Masters) and University (NCSU) will be set facebook has a business process to approve applications, since we don't have any business so it's not possible to make this facebook app based login live. There's another way for approval which is individual but that goes through a week of approval process. We can add you as one of the tester in the development console of facebook then you should be able to login. Please drop an email to one of our team member for this.

Password reset for admin/student/librarian

Mailer set-up (Use personal mail as enterprise emails block the delivery of password reset emails): a. On librarian sign up, an email will be triggered to admin for approval
b. On password reset
c. On book check out Note: Emails will be delivered from jn.ayush@gmail.com

Hold request module:
a. SPECIAL CATEGORY: Student checks out - goes to admin for approval - auto check out on admin approval
b. MAX BOOKS EXCEEDED: Student crosses his limit - auto check out when he returns either of his books
c. BOOK UNAVAILABLE: Hold request raised - auto check out when book back in stock
d. SPECIAL CATEGORY + BOOK UNAVAILABLE: Auto check out when admin approves and book in stock
e. SPECIAL CATEGORY + MAX BOOKS EXCEEDED: Auto check out when admin approves and student returns either of his books

Max books to be check out per student determined on his educational degree This can be changed by admin by degree to book mapping link
