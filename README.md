This README would normally document whatever steps are necessary to get the application up and running.

#### Admin creds: 
**username**: ajain37@ncsu.edu<br/> **password**: 123456

#### Librarian creds: 
**username**: chawandesaahil600@gmail.com<br/> **password**: 123456

#### Student creds: 
**username**: mitagavade@gmail.com<br/> **password**: 123456

Points to be noted:

### Extra Credit Functionalities:

#### Facebook login - Only for student

Default Education level (Masters) and University (NCSU) will be set. Facebook has a business process to approve applications, since we don't have any business so it's not possible to make this facebook app based login live. There's another way for approval which is individual but that goes through a week of approval process. We can add you as one of the tester in the development console of facebook then you should be able to login. Please drop an email to one of our team member for this.

#### Private Information
No student/librarian should can access any private content associated with other student/librarian/admin's account even after modifying the url's. We have the authorization in place for all the modules, as well as session handling in the application. Two different types of users cannot login simultaneouly in the same browser. 

#### Mailer 

Mailer set-up (Use personal mail as enterprise emails block the delivery of password reset emails): <br/>
**Note**: Emails will be delivered from jn.ayush@gmail.com
* On librarian sign up, an email will be triggered to admin for approval
* On password reset
* On book check out 

#### Hold request module:
* SPECIAL CATEGORY: Student checks out - goes to admin for approval - auto check out on admin approval
* MAX BOOKS EXCEEDED: Student crosses his limit - auto check out when he returns either of his books
* BOOK UNAVAILABLE: Hold request raised - auto check out when book back in stock
* SPECIAL CATEGORY + BOOK UNAVAILABLE: Auto check out when admin approves and book in stock
* SPECIAL CATEGORY + MAX BOOKS EXCEEDED: Auto check out when admin approves and student returns either of his books

**Max books to be check out per student determined on his educational degree This can be changed by admin by degree to book mapping link** <br>

#### Manage Students:
Admin can click on manage students link from header to edit student information, create new student and destroy existing one


#### Manage Librarians:
Admin can click on librarian from header to edit librarian information, create new student and destroy existing one
Approval request for new librarian accounts are accessible from the link in header 


