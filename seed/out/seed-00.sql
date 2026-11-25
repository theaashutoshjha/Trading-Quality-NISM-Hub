INSERT INTO courses (id,code,title,subtitle,category,description,level,hours,playlists,links,published,popular,sort) VALUES ('fi-academy','FI ACADEMY','FundsIndia Academy','Investing, SIPs, bonds, stocks & markets','academy','Every public video from the FundsIndia YouTube channel, grouped by topic: investor mindset, getting started on the platform, SIPs and mutual funds, bonds and SIFs, stocks and IPOs, NPS, market views, fund-manager talks, media appearances, customer voices and brand films.','All employees',0,'[]','[]',1,1,0) ON CONFLICT(id) DO UPDATE SET code=excluded.code,title=excluded.title,subtitle=excluded.subtitle,category=excluded.category,description=excluded.description,level=excluded.level,hours=excluded.hours,playlists=excluded.playlists,links=excluded.links,published=excluded.published,popular=excluded.popular,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m0','fi-academy','Start here: investor mindset',NULL,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-QmCKI5RHTGU','fi-academy','fi-academy-m0','3 Stages to cross before you become a good Investor | Watch before investing','video','QmCKI5RHTGU','',1,'FundsIndia',1,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1yJcubWlynY','fi-academy','fi-academy-m0','Investment advice is everywhere. But what’s right for you?','video','1yJcubWlynY','',1,'FundsIndia',1,1) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-SScgY97HoCo','fi-academy','fi-academy-m0','Everyone gives investment advice. But what’s right for you?','video','SScgY97HoCo','',1,'FundsIndia',1,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-pIGL4DTDfuU','fi-academy','fi-academy-m0','Why Long-Term Investing is Your Best Path to Higher Returns','video','pIGL4DTDfuU','',1,'FundsIndia',1,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-XFVW7XNLJcQ','fi-academy','fi-academy-m0','🌟 What If Finance Was a Subject in School? 🌟','video','XFVW7XNLJcQ','',2,'FundsIndia',1,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-QZEZlZuPmCk','fi-academy','fi-academy-m0','Tough times taught me the importance of investing Here''s what I learned through the way 1 Save 10','video','QZEZlZuPmCk','',1,'FundsIndia',1,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-z2R3wD7DgvE','fi-academy','fi-academy-m0','What''s the 1 Financial Lesson that 2022 taught you?','video','z2R3wD7DgvE','',3,'FundsIndia',1,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-enoWBas3jNM','fi-academy','fi-academy-m0','Do You Consider How a Fund Performs During Market Volatility?','video','enoWBas3jNM','',1,'FundsIndia',1,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-0QbW0uLdScc','fi-academy','fi-academy-m0','Have you diversified your investments?','video','0QbW0uLdScc','',1,'FundsIndia',1,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-hSRsO9Ej1vA','fi-academy','fi-academy-m0','How long have you stayed invested?','video','hSRsO9Ej1vA','',1,'FundsIndia',1,9) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-P70OfEboDhQ','fi-academy','fi-academy-m0','How often do you check your portfolio?','video','P70OfEboDhQ','',1,'FundsIndia',1,10) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-QYxyYwu7dvE','fi-academy','fi-academy-m0','What Happens When Investors Lose Their Balance? | The Balance Test','video','QYxyYwu7dvE','',1,'FundsIndia',1,11) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Mde1tgG_aUI','fi-academy','fi-academy-m0','DIY vs Guided Investing: The difference is bigger than you think','video','Mde1tgG_aUI','',2,'FundsIndia',1,12) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Q8scqQA8RD0','fi-academy','fi-academy-m0','Who actually stays invested: DIY or guided investors?','video','Q8scqQA8RD0','',1,'FundsIndia',1,13) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-psGBBGROXRM','fi-academy','fi-academy-m0','Three good calls in a row. Does that make you a better investor, or just a lucky one?','video','psGBBGROXRM','',1,'FundsIndia',1,14) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-UhGGYwxRWOI','fi-academy','fi-academy-m0','Understand the Union Budget in 4 Minutes | Part 1 - Income, Spending & Deficit','video','UhGGYwxRWOI','',4,'FundsIndia',1,15) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-g9OhCpnfX14','fi-academy','fi-academy-m0','Understand the Union Budget in 4 Minutes | Part 2 - Where will India spend its money?','video','g9OhCpnfX14','',4,'FundsIndia',1,16) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m1','fi-academy','Getting started on FundsIndia',NULL,1) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1YUMa8PEwZ4','fi-academy','fi-academy-m1','How to Invest in IPO through FundsIndia?','video','1YUMa8PEwZ4','',3,'FundsIndia',1,17) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ZCvHa913oZU','fi-academy','fi-academy-m1','How to Buy / Sell a Stock through FundsIndia?','video','ZCvHa913oZU','',2,'FundsIndia',1,18) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-P_POWz3pxZQ','fi-academy','fi-academy-m1','How to create Stock SIP for Your Child through the FundsIndia App?','video','P_POWz3pxZQ','',1,'FundsIndia',1,19) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-oD-pKYG62jk','fi-academy','fi-academy-m1','How to Invest in IPO through FundsIndia?','video','oD-pKYG62jk','',3,'FundsIndia',1,20) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-7BEZ26n4W44','fi-academy','fi-academy-m1','Install FundsIndia App & Get Stock Recommendations at your FingerTips!','video','7BEZ26n4W44','',1,'FundsIndia',1,21) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-2m5gTM7bDRY','fi-academy','fi-academy-m1','How to Open a Demat Account with FundsIndia?','video','2m5gTM7bDRY','',3,'FundsIndia',1,22) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-GAUbeLXr33Q','fi-academy','fi-academy-m1','Confused about where to start your investment journey?🤯𝐌𝐞𝐞𝐭 𝐭𝐡𝐞 5 𝐅𝐢𝐧𝐠𝐞𝐫 𝐒𝐭𝐫𝐚𝐭𝐞𝐠𝐲.','video','GAUbeLXr33Q','',1,'FundsIndia',1,23) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-dC4sqAg1PV0','fi-academy','fi-academy-m1','FundsIndia''s Dashboard Demo','video','dC4sqAg1PV0','',2,'FundsIndia',1,24) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-zuh46r0YcIg','fi-academy','fi-academy-m1','SIP investing with FundsIndia','video','zuh46r0YcIg','',2,'FundsIndia',1,25) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-LCcojjNJH3M','fi-academy','fi-academy-m1','FundsIndia''s Demo on Switching Investments','video','LCcojjNJH3M','',1,'FundsIndia',1,26) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ZgMR5DbSAyQ','fi-academy','fi-academy-m1','Lump sum investing with FundsIndia','video','ZgMR5DbSAyQ','',1,'FundsIndia',1,27) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-2q-_eTVw4ZY','fi-academy','fi-academy-m1','Start Your Investment Journey With Expert Guidance - Install FundsIndia App Now!','video','2q-_eTVw4ZY','',1,'FundsIndia',1,28) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-66vqXGyi6aM','fi-academy','fi-academy-m1','FundsIndia.com - The smartest way to invest in Mutual Funds and more','video','66vqXGyi6aM','',3,'FundsIndia',1,29) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-JCaUSWBrgsg','fi-academy','fi-academy-m1','How to invest through FundsIndia App?','video','JCaUSWBrgsg','',1,'FundsIndia',1,30) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-z_HO0E87Y5E','fi-academy','fi-academy-m1','Start your investment journey with FundsIndia today','video','z_HO0E87Y5E','',1,'FundsIndia',1,31) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-nm8BpFKBNoE','fi-academy','fi-academy-m1','Secure Your Kid''s Future by Investing through FundsIndia','video','nm8BpFKBNoE','',1,'FundsIndia',1,32) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-6NJpXIO7Uxw','fi-academy','fi-academy-m1','How to invest in SIP via FundsIndia Portal on Desktop?','video','6NJpXIO7Uxw','',3,'FundsIndia',1,33) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-8xRkmFqVqTI','fi-academy','fi-academy-m1','How to invest Lumpsum via FundsIndia Portal on Desktop?','video','8xRkmFqVqTI','',2,'FundsIndia',1,34) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-J8ossyN0eEs','fi-academy','fi-academy-m1','How to invest Lumpsum via FundsIndia App','video','J8ossyN0eEs','',1,'FundsIndia',1,35) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-uON4zMHjZcg','fi-academy','fi-academy-m1','How to Invest in an SIP through the FundsIndia Mobile App?','video','uON4zMHjZcg','',2,'FundsIndia',1,36) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-gx3SGuwRcsw','fi-academy','fi-academy-m1','Instantly create your FundsIndia account','video','gx3SGuwRcsw','',1,'FundsIndia',1,37) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Q1Ec6s7D5hA','fi-academy','fi-academy-m1','Give your employees the FundsIndia Academy edge!','video','Q1Ec6s7D5hA','',1,'FundsIndia',1,38) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-LNq4Ojogvx0','fi-academy','fi-academy-m1','This investor loves our Super Savings Account. Watch to know why!','video','LNq4Ojogvx0','',1,'FundsIndia',1,39) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-FNdbpHqyLpk','fi-academy','fi-academy-m1','Introducing Fundsindia''s Super Savings Account!','video','FNdbpHqyLpk','',2,'FundsIndia',1,40) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1PHSQtcV06M','fi-academy','fi-academy-m1','Save trees and time - Go paperless with FundsIndia','video','1PHSQtcV06M','',1,'FundsIndia',1,41) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-3Qam3Gm9588','fi-academy','fi-academy-m1','The FundsIndia Dashboard','video','3Qam3Gm9588','',1,'FundsIndia',1,42) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-QBy1h0t6KeQ','fi-academy','fi-academy-m1','New India Portfolio','video','QBy1h0t6KeQ','',1,'FundsIndia',1,43) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-YgX3LID0GQQ','fi-academy','fi-academy-m1','FundsIndia.com - The smartest way to invest in Mutual Funds and more','video','YgX3LID0GQQ','',1,'FundsIndia',1,44) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m2','fi-academy','SIPs & mutual funds',NULL,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-6YSk4SySuCg','fi-academy','fi-academy-m2','How do you choose which Mutual Funds to invest in? Balance','video','6YSk4SySuCg','',1,'FundsIndia',1,45) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-WMxzWMsv20o','fi-academy','fi-academy-m2','The Power of Step-up SIP: Take Small Steps for creating Big Wealth','video','WMxzWMsv20o','',1,'FundsIndia',1,46) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-14qhtgSuTXA','fi-academy','fi-academy-m2','No Market Dramas should Hinder you from Investing!','video','14qhtgSuTXA','',1,'FundsIndia',1,47) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-DHwoXHXM6Wo','fi-academy','fi-academy-m2','What is a Market Bubble?','video','DHwoXHXM6Wo','',2,'FundsIndia',1,48) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-NmsCMKyXUIw','fi-academy','fi-academy-m2','What is a 8-4-3 Rule in Investing?','video','NmsCMKyXUIw','',1,'FundsIndia',1,49) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-VtYNfqv_poY','fi-academy','fi-academy-m2','What is 7-5-3-1 Rule in Investing?','video','VtYNfqv_poY','',1,'FundsIndia',1,50) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-48YYtbKltN4','fi-academy','fi-academy-m2','Is past performance of mutual funds enough to predict their future performance?','video','48YYtbKltN4','',3,'FundsIndia',1,51) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ebjAoOEoCFk','fi-academy','fi-academy-m2','Do Equity SIPs work best on certain dates of the month? | FundsIndia Mutual Funds','video','ebjAoOEoCFk','',3,'FundsIndia',1,52) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-KqWir9FKbS8','fi-academy','fi-academy-m2','Demystifying Home Loan EMIs: What They Don''t Tell You - Part 2 | FundsIndia Mutual Funds','video','KqWir9FKbS8','',1,'FundsIndia',1,53) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-t1A-RSyCzUs','fi-academy','fi-academy-m2','Take Charge of Your Money with This Quick and Simple Framework | FundsIndia Mutual Funds','video','t1A-RSyCzUs','',2,'FundsIndia',1,54) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-LxTE4CMudoQ','fi-academy','fi-academy-m2','Demystifying Home Loan EMIs: What They Don''t Tell You - Part 1 | FundsIndia Mutual Funds','video','LxTE4CMudoQ','',1,'FundsIndia',1,55) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-TON5OMjvHKI','fi-academy','fi-academy-m2','House Hunting: The Art of Choosing Between Renting and Buying','video','TON5OMjvHKI','',2,'FundsIndia',1,56) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-RNVc-sKlfRM','fi-academy','fi-academy-m2','DSP Global Innovation Fund of Fund - Everything you need to know','video','RNVc-sKlfRM','',2,'FundsIndia',1,57) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-EfJSvo8G1jg','fi-academy','fi-academy-m2','ELSS - Route to Success','video','EfJSvo8G1jg','',1,'FundsIndia',1,58) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1m586YpeYss','fi-academy','fi-academy-m2','ICICI Pru Midcap 150 Index Fund | FundsIndia360°','video','1m586YpeYss','',2,'FundsIndia',1,59) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-n4OqlyBildM','fi-academy','fi-academy-m2','All You Need To Know About ELSS','video','n4OqlyBildM','',2,'FundsIndia',1,60) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-LwN3iwDXuAA','fi-academy','fi-academy-m2','What is SIP & How does it work?','video','LwN3iwDXuAA','',2,'FundsIndia',1,61) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9ehbY24Ysns','fi-academy','fi-academy-m2','ICICI Prudential Passive Multi-Asset Fund of Funds | FundsIndia360°','video','9ehbY24Ysns','',3,'FundsIndia',1,62) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-05a4iVh8Wu0','fi-academy','fi-academy-m2','Equity SIP returns have become low. What should you do?','video','05a4iVh8Wu0','',9,'FundsIndia',1,63) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Wg-MMT4rshU','fi-academy','fi-academy-m2','Mutual Fund Investing Made Easy | Why 29 Lakh+ Indians Trust FundsIndia','video','Wg-MMT4rshU','',1,'FundsIndia',1,64) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-8RTfHWsJ_TA','fi-academy','fi-academy-m2','What makes a Disciplined SIP Investor?','video','8RTfHWsJ_TA','',1,'FundsIndia',1,65) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-0rq9FBPOMKM','fi-academy','fi-academy-m2','What Happens When You Increase Your SIP Every Year? | FundsIndia | SIP | Mutual Funds','video','0rq9FBPOMKM','',1,'FundsIndia',1,66) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-up6laNhYD0U','fi-academy','fi-academy-m2','Why Is It Important to Start Investing Early? | FundsIndia | Mutual Funds | SIP','video','up6laNhYD0U','',1,'FundsIndia',1,67) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-SLZK6zDL8BI','fi-academy','fi-academy-m2','Why Most People Get SIP vs Lumpsum Wrong','video','SLZK6zDL8BI','',3,'FundsIndia',1,68) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-3fOy1tqLgp0','fi-academy','fi-academy-m2','How Long Should You Stay Invested in a SIP?','video','3fOy1tqLgp0','',1,'FundsIndia',1,69) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-s4YofbPmFRc','fi-academy','fi-academy-m2','Why You Should Increase Your SIP by 10% Every Year','video','s4YofbPmFRc','',1,'FundsIndia',1,70) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-BWypUHxs7ck','fi-academy','fi-academy-m2','Why Your SIP Feels Slow at First | The 8-4-3 Rule','video','BWypUHxs7ck','',2,'FundsIndia',1,71) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-RKFsagBxtuk','fi-academy','fi-academy-m2','Before You Invest in Any Mutual Fund, Watch This','video','RKFsagBxtuk','',3,'FundsIndia',1,72) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-sZ5Uv3duh80','fi-academy','fi-academy-m2','What data reveals about "Best" Mutual Funds','video','sZ5Uv3duh80','',2,'FundsIndia',1,73) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Nxl8qOOkwA0','fi-academy','fi-academy-m2','Watch this video to choose the right Mutual Funds to invest in','video','Nxl8qOOkwA0','',1,'FundsIndia',1,74) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-QmU00ZEW6Io','fi-academy','fi-academy-m2','Don''t get overwhelmed, watch this video to choose the right Mutual Funds','video','QmU00ZEW6Io','',1,'FundsIndia',1,75) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-72IocNPzY58','fi-academy','fi-academy-m2','Have you ever felt overwhelmed by choosing the right mutual funds You’re not alone! Picking the best','video','72IocNPzY58','',1,'FundsIndia',1,76) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-QdTX5qBpWlI','fi-academy','fi-academy-m2','Start investing in Mutual Funds today','video','QdTX5qBpWlI','',1,'FundsIndia',1,77) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v--kqG-vssD-I','fi-academy','fi-academy-m2','Why you should start investing early? | FundsIndia Mutual Funds','video','-kqG-vssD-I','',1,'FundsIndia',1,78) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-WTTObWHpa2k','fi-academy','fi-academy-m2','Introducing Loan Against Mutual Funds | FundsIndia | Mirae Asset','video','WTTObWHpa2k','',1,'FundsIndia',1,79) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-D2E7DjhHG44','fi-academy','fi-academy-m2','Power STP - A FundsIndia Exclusive','video','D2E7DjhHG44','',2,'FundsIndia',1,80) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ssL4nZH4DTc','fi-academy','fi-academy-m2','NFO: Sundaram Equity Fund','video','ssL4nZH4DTc','',1,'FundsIndia',1,81) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-rPb-M-fStuk','fi-academy','fi-academy-m2','Invest in Smart SIP and Earn 2.6% more than your SIP','video','rPb-M-fStuk','',4,'FundsIndia',1,82) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-BFrkcap5gdA','fi-academy','fi-academy-m2','Does a ₹100 SIP make sense?','video','BFrkcap5gdA','',4,'FundsIndia',1,83) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-EkfgCX2QlJc','fi-academy','fi-academy-m2','Invest in the Motilal Oswal Nasdaq 100 Fund of Fund','video','EkfgCX2QlJc','',2,'FundsIndia',1,84) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-vPHXMLfrH3g','fi-academy','fi-academy-m2','ICICI Prudential Nifty Next 50 Index fund - Invest in tomorrow','video','vPHXMLfrH3g','',2,'FundsIndia',1,85) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-5Sx_InmdNyY','fi-academy','fi-academy-m2','SIP with FREE Insurance - Build wealth & protect your family','video','5Sx_InmdNyY','',2,'FundsIndia',1,86) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-UwD9jqSQHws','fi-academy','fi-academy-m2','Why you should start an SIP today!','video','UwD9jqSQHws','',2,'FundsIndia',1,87) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-8vIyMbfSMI4','fi-academy','fi-academy-m2','The easiest way to start an SIP','video','8vIyMbfSMI4','',1,'FundsIndia',1,88) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Zw7MYpW9i-w','fi-academy','fi-academy-m2','Achieve your goals easily with an SIP','video','Zw7MYpW9i-w','',1,'FundsIndia',1,89) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-e16XjGrIcis','fi-academy','fi-academy-m2','Benefits of Tax saving instruments','video','e16XjGrIcis','',1,'FundsIndia',1,90) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m3','fi-academy','Bonds, FDs & SIFs',NULL,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-pTXA4FFsdds','fi-academy','fi-academy-m3','Don''t buy Bonds Without Checking these 3 Things.','video','pTXA4FFsdds','',4,'FundsIndia',1,91) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-bJrM2cdiPkA','fi-academy','fi-academy-m3','Equity vs Debt vs Hybrid SIFs: Which One Actually Fits Your Risk?','video','bJrM2cdiPkA','',3,'FundsIndia',1,92) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-kTt6LJmBmcY','fi-academy','fi-academy-m3','Bonds: Where Do I Even Start?','video','kTt6LJmBmcY','',1,'FundsIndia',1,93) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1G303rytQhc','fi-academy','fi-academy-m3','What are Bonds? | Should you in invest?','video','1G303rytQhc','',6,'FundsIndia',1,94) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-_uMEDzinY_M','fi-academy','fi-academy-m3','Specialized Investment Fund (SIF) Explained | SEBI Rules, Tax & Minimum Investment','video','_uMEDzinY_M','',4,'FundsIndia',1,95) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-HKAElEMOO4A','fi-academy','fi-academy-m3','Cumulative Vs Non Cumulative Interest rates in FDs','video','HKAElEMOO4A','',2,'FundsIndia',1,96) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-38FSNxHMXvE','fi-academy','fi-academy-m3','All you need to know about FD Laddering | FundsIndia | Fixed Deposit','video','38FSNxHMXvE','',2,'FundsIndia',1,97) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m4','fi-academy','Stocks & IPOs',NULL,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-zgTfMnIXrHA','fi-academy','fi-academy-m4','What are bull and bear markets?','video','zgTfMnIXrHA','',1,'FundsIndia',1,98) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-2HKGeaYx7f4','fi-academy','fi-academy-m4','What are candlesticks?','video','2HKGeaYx7f4','',1,'FundsIndia',1,99) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-mOcXD4PBRjg','fi-academy','fi-academy-m4','What is a bid and ask price? | FIStocademy','video','mOcXD4PBRjg','',1,'FundsIndia',1,100) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-x4rRsovVRUQ','fi-academy','fi-academy-m4','What are indicators?','video','x4rRsovVRUQ','',1,'FundsIndia',1,101) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-2RX4B3KuwPw','fi-academy','fi-academy-m4','Trade F&O with Low Brokerage & Expert Guidance with FundsIndia 📉📈','video','2RX4B3KuwPw','',1,'FundsIndia',1,102) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-gGxeRoqDzJQ','fi-academy','fi-academy-m4','Exciting Offer for F&O Traders | Trade Smarter with FundsIndia 🔥📈','video','gGxeRoqDzJQ','',1,'FundsIndia',1,103) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-wA5CgGp1bFs','fi-academy','fi-academy-m4','5 Benefits You Can Enjoy Investing in Stocks','video','wA5CgGp1bFs','',3,'FundsIndia',1,104) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-U9LgJq7HH3M','fi-academy','fi-academy-m4','NTPC Green IPO - All You Need To Know','video','U9LgJq7HH3M','',2,'FundsIndia',1,105) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-jw-Wzaf6Jhc','fi-academy','fi-academy-m4','Trivia| Artificial Intelligence| AI Stocks','video','jw-Wzaf6Jhc','',1,'FundsIndia',1,106) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-0vVrni9bCbU','fi-academy','fi-academy-m4','Can you enter the stock market with a small sum of money? | Myth vs Fact - Part 1','video','0vVrni9bCbU','',2,'FundsIndia',1,107) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-OTZz7oGNSis','fi-academy','fi-academy-m4','What is Margin Trading Facility (MTF)? | FundsIndia Broking','video','OTZz7oGNSis','',2,'FundsIndia',1,108) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-68PcpVmgjB4','fi-academy','fi-academy-m4','Sovereign Gold Bonds (SGB) - A Smart Choice for Your Portfolio','video','68PcpVmgjB4','',3,'FundsIndia',1,109) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-UjhWOJdW79c','fi-academy','fi-academy-m4','All you need to know about Dividends | Part 2','video','UjhWOJdW79c','',2,'FundsIndia',1,110) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-prwC2xkOPdI','fi-academy','fi-academy-m4','All you need to know about Dividends - Part 1 | Top 5 Dividend Yielding Stocks','video','prwC2xkOPdI','',3,'FundsIndia',1,111) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-l7vSQad9L5Y','fi-academy','fi-academy-m4','Mankind Pharma IPO Review | All you need to know | FundsIndiaBroking','video','l7vSQad9L5Y','',2,'FundsIndia',1,112) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Gm5JJ_fTqfU','fi-academy','fi-academy-m4','Better Than Gold | Akshaya Tritiya Special','video','Gm5JJ_fTqfU','',2,'FundsIndia',1,113) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-d0aWncCDBQo','fi-academy','fi-academy-m4','Avalon Technologies IPO Review | All you need to know | FundsIndiaBroking','video','d0aWncCDBQo','',1,'FundsIndia',1,114) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-B7YtxTERVqE','fi-academy','fi-academy-m4','All you need to know about the DCX Systems IPO','video','B7YtxTERVqE','',2,'FundsIndia',1,115) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-TTDz4GMIbiY','fi-academy','fi-academy-m4','Watch This Video To Unlock The Power of Stock SIPs','video','TTDz4GMIbiY','',2,'FundsIndia',1,116) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-krafBXib5S0','fi-academy','fi-academy-m4','Why Are Defence Stocks Rising When Markets Are Falling? | FI Sector Pulse - Nifty Defence Index','video','krafBXib5S0','',4,'FundsIndia',1,117) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-I8T6We19qNs','fi-academy','fi-academy-m4','What is an Alpha Stock Report by FundsIndia?','video','I8T6We19qNs','',2,'FundsIndia',1,118) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-KjcthL4isKY','fi-academy','fi-academy-m4','How to Increase Your IPO Allotment Chances?','video','KjcthL4isKY','',3,'FundsIndia',1,119) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-a0jme8t--cQ','fi-academy','fi-academy-m4','Transport Corporation of India Ltd: ALPHA Stock Analysis (October)','video','a0jme8t--cQ','',1,'FundsIndia',1,120) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1A_rXTlsxWs','fi-academy','fi-academy-m4','EPL Stock Analysis - Alpha (September 12, 2024)','video','1A_rXTlsxWs','',1,'FundsIndia',1,121) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9LDUKcS-x7g','fi-academy','fi-academy-m4','Two Industry Giants Are Launching Theri IPOs','video','9LDUKcS-x7g','',1,'FundsIndia',1,122) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m5','fi-academy','NPS & retirement',NULL,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-YJ-Q2_i7ll0','fi-academy','fi-academy-m5','Why NPS might just be the financial game-changer you''ve been waiting for?','video','YJ-Q2_i7ll0','',2,'FundsIndia',1,123) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-qT53rI_9KiQ','fi-academy','fi-academy-m5','All you need to know about NPS | Part 2 | Diversification','video','qT53rI_9KiQ','',4,'FundsIndia',1,124) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-BY3iWRG-5rs','fi-academy','fi-academy-m5','All you need to know about NPS | Part 1 | Liquidity','video','BY3iWRG-5rs','',2,'FundsIndia',1,125) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-aTBwHmm1Kvk','fi-academy','fi-academy-m5','NPS - The Financial Safety Net','video','aTBwHmm1Kvk','',1,'FundsIndia',1,126) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-vMtUUwOcU0k','fi-academy','fi-academy-m5','NPS - The Perfect Tax Defender','video','vMtUUwOcU0k','',1,'FundsIndia',1,127) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-W72Tg3fm4Hw','fi-academy','fi-academy-m5','How to save tax from the tax man? | The BIG 3 | ELSS | NPS | Insurance','video','W72Tg3fm4Hw','',1,'FundsIndia',1,128) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-905NV93OEXk','fi-academy','fi-academy-m5','NPS - Route To Achieve Golden Ticket','video','905NV93OEXk','',1,'FundsIndia',1,129) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-O1oI7WfpfW0','fi-academy','fi-academy-m5','Invest early | Retire early','video','O1oI7WfpfW0','',1,'FundsIndia',1,130) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m6','fi-academy','Market views & roundups',NULL,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Xmqqw3x0Jgs','fi-academy','fi-academy-m6','Weekly Market Roundup | Aug 5, 2023 to Aug 11, 2023','video','Xmqqw3x0Jgs','',1,'FundsIndia',1,131) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-jSCrCWL_b4Q','fi-academy','fi-academy-m6','Weekly Market Roundup | Aug 27, 2023 to Sep 01, 2023','video','jSCrCWL_b4Q','',1,'FundsIndia',1,132) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-5YuZXiCFBMM','fi-academy','fi-academy-m6','Weekly Market Roundup | Sep 02, 2023 to Sep 08, 2023','video','5YuZXiCFBMM','',1,'FundsIndia',1,133) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-quPeSPo2Q5k','fi-academy','fi-academy-m6','Weekly Market Roundup | Sep 09, 2023 to Sep 15, 2023','video','quPeSPo2Q5k','',1,'FundsIndia',1,134) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-mtNlBhXjNcY','fi-academy','fi-academy-m6','Weekly Market Roundup | Sep 16, 2023 to Sep 22, 2023','video','mtNlBhXjNcY','',1,'FundsIndia',1,135) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-0VGtZFvogBA','fi-academy','fi-academy-m6','Weekly Market Roundup | Sep 23, 2023 to Sep 29, 2023','video','0VGtZFvogBA','',1,'FundsIndia',1,136) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-GBkylwEZquQ','fi-academy','fi-academy-m6','Weekly Market Roundup | Sep 30, 2023 to Oct 06, 2023','video','GBkylwEZquQ','',1,'FundsIndia',1,137) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-DpMhkw2dO2A','fi-academy','fi-academy-m6','Weekly Market Roundup | Oct 07, 2023 to Oct 13, 2023','video','DpMhkw2dO2A','',1,'FundsIndia',1,138) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9SeS_wYLmWE','fi-academy','fi-academy-m6','Weekly Market Roundup | Oct 14, 2023 to Oct 20, 2023','video','9SeS_wYLmWE','',1,'FundsIndia',1,139) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-XEtXB4ph6OA','fi-academy','fi-academy-m6','Weekly Market Roundup | Oct 21 - Oct 27, 2023','video','XEtXB4ph6OA','',1,'FundsIndia',1,140) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-l5ABt2eN7HU','fi-academy','fi-academy-m6','Weekly Market Roundup | Oct 28 - Nov 03, 2023','video','l5ABt2eN7HU','',1,'FundsIndia',1,141) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-MYBtVh1FDX0','fi-academy','fi-academy-m6','Weekly Market Roundup | Nov 04 - Nov 10, 2023','video','MYBtVh1FDX0','',1,'FundsIndia',1,142) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-rkpoGf0TUA0','fi-academy','fi-academy-m6','Weekly Market Roundup | Nov 11 - Nov 17, 2023 | FundsIndiaMarketry','video','rkpoGf0TUA0','',1,'FundsIndia',1,143) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-IKnth3FOXqA','fi-academy','fi-academy-m6','Weekly Market Roundup | Nov 18 - Nov 24,2023','video','IKnth3FOXqA','',1,'FundsIndia',1,144) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ONfunOc956A','fi-academy','fi-academy-m6','Weekly Market Roundup | Nov 25 - Dec 01,2023','video','ONfunOc956A','',1,'FundsIndia',1,145) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-IJuyurfAvwg','fi-academy','fi-academy-m6','Weekly Market Roundup | Dec 02 - Dec 08,2023','video','IJuyurfAvwg','',1,'FundsIndia',1,146) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-BrPc60V9Re0','fi-academy','fi-academy-m6','Weekly Market Roundup | Dec 09 - Dec 15,2023 | FundsIndiaMarketry','video','BrPc60V9Re0','',1,'FundsIndia',1,147) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-xrUJh3KWbiA','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - October‘23','video','xrUJh3KWbiA','',28,'FundsIndia',1,148) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-wkM_X4pHMNY','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - September‘23','video','wkM_X4pHMNY','',36,'FundsIndia',1,149) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-NOzv8NT_A4I','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - July‘23','video','NOzv8NT_A4I','',25,'FundsIndia',1,150) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-7QZBEFbCloQ','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - June‘23','video','7QZBEFbCloQ','',31,'FundsIndia',1,151) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-rfEpFqREWM0','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - May ‘23','video','rfEpFqREWM0','',29,'FundsIndia',1,152) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-qkoRzFDepT8','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - April ‘23','video','qkoRzFDepT8','',20,'FundsIndia',1,153) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-2YNZWDce9Ao','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - March ‘23','video','2YNZWDce9Ao','',30,'FundsIndia',1,154) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-BXrM1u5RcEI','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - February ‘23','video','BXrM1u5RcEI','',30,'FundsIndia',1,155) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-2hV1yTYEctA','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - January ‘23','video','2hV1yTYEctA','',30,'FundsIndia',1,156) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-C43qdhtpISM','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - December ‘22','video','C43qdhtpISM','',39,'FundsIndia',1,157) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-W-9csd0neZ4','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - November ‘22','video','W-9csd0neZ4','',27,'FundsIndia',1,158) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-GFK-z5SA6RI','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - October ‘22','video','GFK-z5SA6RI','',36,'FundsIndia',1,159) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9cb6wzoJsLY','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - September ‘22','video','9cb6wzoJsLY','',32,'FundsIndia',1,160) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9u4Udgn2ipU','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - July ‘22','video','9u4Udgn2ipU','',34,'FundsIndia',1,161) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-JUfONG6y8x4','fi-academy','fi-academy-m6','Market Lounge Reloaded | Session - June ‘22','video','JUfONG6y8x4','',45,'FundsIndia',1,162) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-usvWNxX4fWk','fi-academy','fi-academy-m6','Market Lounge | Session - March ‘21','video','usvWNxX4fWk','',66,'FundsIndia',1,163) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-sNkayWd_fQY','fi-academy','fi-academy-m6','Market Falls Can Help Your SIP. Why?','video','sNkayWd_fQY','',1,'FundsIndia',1,164) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-grLCmSWERkE','fi-academy','fi-academy-m6','Market Wrap 2025 | India & Global Markets Explained','video','grLCmSWERkE','',5,'FundsIndia',1,165) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-isyHpszet80','fi-academy','fi-academy-m6','Weekly Market Roundup | Aug 19, 2023 to Aug 26, 2023','video','isyHpszet80','',1,'FundsIndia',1,166) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-EHNAWQj1BPU','fi-academy','fi-academy-m6','Weekly Market Roundup | Aug 12, 2023 to Aug 18, 2023','video','EHNAWQj1BPU','',1,'FundsIndia',1,167) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-wwt9OD9Bwic','fi-academy','fi-academy-m6','Weekly Market Roundup - Jul 15 - Jul 21','video','wwt9OD9Bwic','',1,'FundsIndia',1,168) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-QKgRJ8CAGWQ','fi-academy','fi-academy-m6','Weekly Market Roundup - Jul 01 - Jul 07','video','QKgRJ8CAGWQ','',1,'FundsIndia',1,169) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ge9mmeVIKls','fi-academy','fi-academy-m6','Weekly Market Roundup - May 13 - May 19','video','ge9mmeVIKls','',1,'FundsIndia',1,170) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-2MrA8buzf40','fi-academy','fi-academy-m6','Weekly Market Roundup - Apr 07 - Apr 13','video','2MrA8buzf40','',1,'FundsIndia',1,171) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-RuZOvo2TxW0','fi-academy','fi-academy-m6','Weekly Market Round-up - Mar 04 to Mar 10','video','RuZOvo2TxW0','',1,'FundsIndia',1,172) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-lZQgh9BL8F8','fi-academy','fi-academy-m6','Weekly Market Roundup - Jan 07, 2023 - Jan 13, 2023','video','lZQgh9BL8F8','',1,'FundsIndia',1,173) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-YPnZG04Eub8','fi-academy','fi-academy-m6','Yearly Market Roundup 2022','video','YPnZG04Eub8','',3,'FundsIndia',1,174) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Q-o2MoQ1udc','fi-academy','fi-academy-m6','Elections 2019 are coming up! Is now a good time to invest?','video','Q-o2MoQ1udc','',3,'FundsIndia',1,175) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-wUtYNhjlw9s','fi-academy','fi-academy-m6','Ab market ke utar-chadhav ka darr kaisa? - Balanced Advantage Fund','video','wUtYNhjlw9s','',2,'FundsIndia',1,176) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m7','fi-academy','Behind The Returns: fund manager talks',NULL,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-GW6mXclom54','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E01 | Mr. Jinesh Gopani, Head of Equities, Axis Mutual Fund','video','GW6mXclom54','',29,'FundsIndia',1,177) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9LgEL8-LZwg','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E012 | Mr.Mahendra Kumar Jajoo – CIO - Debt, Mirae Asset','video','9LgEL8-LZwg','',38,'FundsIndia',1,178) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-jnBbaq3Rbic','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E012 | Mr.Nimesh Chandan – Head Investments-Equity, Canara Robeco MF','video','jnBbaq3Rbic','',50,'FundsIndia',1,179) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-TNzgo0Pu1n0','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E011 | Mr.Shreyash Devalkar – Senior Fund Manager Equity, Axis AMC','video','TNzgo0Pu1n0','',33,'FundsIndia',1,180) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-n9OiNKRVKfA','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E010 | Mr.Pankaj Tibrewal – Senior Fund Manager, Kotak Mutual Fund','video','n9OiNKRVKfA','',44,'FundsIndia',1,181) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-FGyAY8LNE-4','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E09 | Ms Aparna Karnik , DSP Investment Managers','video','FGyAY8LNE-4','',37,'FundsIndia',1,182) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Ff9oUjLPN7I','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E08 | Mr Sridatta Bhandwaldar - Head of Equities, Canara Robeco MF','video','Ff9oUjLPN7I','',52,'FundsIndia',1,183) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-c-H9EirSgms','fi-academy','fi-academy-m7','FundsIndia Behind The Returns | E06 | Mr Suyash Choudhary - Fixed Income Head, IDFC Asset Management','video','c-H9EirSgms','',62,'FundsIndia',1,184) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-walUddO62x0','fi-academy','fi-academy-m7','Mr.NileshShah’s ConCall with FundsIndia Investors','video','walUddO62x0','',65,'FundsIndia',1,185) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-4btSqebBQ88','fi-academy','fi-academy-m7','Facebook Live with FundsIndia featuring Bharath regarding Sundaram Equity Fund','video','4btSqebBQ88','',50,'FundsIndia',1,186) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m8','fi-academy','FundsIndia 360° & media appearances',NULL,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-BDxRe_Ffeek','fi-academy','fi-academy-m8','FundsIndia Surpasses 25,000 Cr AUM Milestone!','video','BDxRe_Ffeek','',2,'FundsIndia',1,187) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-GC-7xF2CD18','fi-academy','fi-academy-m8','Geopolitical Tensions vs Portfolio: Markets Are Shaking, Should Investors Be Worried?','video','GC-7xF2CD18','',1,'FundsIndia',1,188) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-F-EZpc1Q72k','fi-academy','fi-academy-m8','Final Episode Spotlight: FundsIndia’s Journey Goes National | Akshay Sapru LIVE on CNBC TV18','video','F-EZpc1Q72k','',1,'FundsIndia',1,189) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-lA6jCDq5saI','fi-academy','fi-academy-m8','FundsIndia Digital: Making Investing Simple, Smart & Accessible for a Wealthier India 💼','video','lA6jCDq5saI','',2,'FundsIndia',1,190) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-3iqJid-UbYw','fi-academy','fi-academy-m8','Advice for Emotional Investors: How to Navigate Market Panic?📉➡️📈','video','3iqJid-UbYw','',3,'FundsIndia',1,191) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-hKLh-7ZyDXg','fi-academy','fi-academy-m8','3 Investment Options Beginners Should Go For','video','hKLh-7ZyDXg','',1,'FundsIndia',1,192) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-j8fmKkUE5RY','fi-academy','fi-academy-m8','3 Common Investor Blind Spots You Can’t Afford to Ignore!','video','j8fmKkUE5RY','',1,'FundsIndia',1,193) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-HQDY1MfHLXE','fi-academy','fi-academy-m8','3 Must-Ask Questions for Salaried Individuals to Master Investing','video','HQDY1MfHLXE','',1,'FundsIndia',1,194) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-TJ4kEnAV850','fi-academy','fi-academy-m8','3 Financial Goals Every Salaried Person Must Plan | FundsIndia x CNBCTV18','video','TJ4kEnAV850','',1,'FundsIndia',1,195) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1D2slk7daWI','fi-academy','fi-academy-m8','Smart Moves, Smarter Money – Episode 4 | Are your investments aligned with your goals?','video','1D2slk7daWI','',22,'FundsIndia',1,196) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-udnDm4I8ed4','fi-academy','fi-academy-m8','Smart Moves, Smarter Money: FundsIndia X CNBC TV 18 | Episode 04 Promo','video','udnDm4I8ed4','',1,'FundsIndia',1,197) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-JENU8-ro9pY','fi-academy','fi-academy-m8','Are you a FOMO Investor or a Smart Investor?','video','JENU8-ro9pY','',2,'FundsIndia',1,198) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-gc_xDznuLA4','fi-academy','fi-academy-m8','Is your financial Guru a social media influencer?!','video','gc_xDznuLA4','',2,'FundsIndia',1,199) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-xF0jL15KWw8','fi-academy','fi-academy-m8','SIPs Over 7 Years = Positive Returns!','video','xF0jL15KWw8','',1,'FundsIndia',1,200) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9NipFPxWBl4','fi-academy','fi-academy-m8','Can your friends'' financial plan work for you?','video','9NipFPxWBl4','',2,'FundsIndia',1,201) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-74xLvlUMdUc','fi-academy','fi-academy-m8','EMIs or SIPs?','video','74xLvlUMdUc','',2,'FundsIndia',1,202) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ck_lq0jPQDI','fi-academy','fi-academy-m8','Chasing High Returns? Watch this!','video','ck_lq0jPQDI','',1,'FundsIndia',1,203) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-nKePEWbeYmM','fi-academy','fi-academy-m8','FundsIndia’s Vision Explained by CEO Akshay Sapru on CNBC-TV18 | How India Will Build Smarter Money?','video','nKePEWbeYmM','',24,'FundsIndia',1,204) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-qOHN08iQdpA','fi-academy','fi-academy-m8','Smart Moves, Smarter Money: FundsIndia X CNBC TV 18','video','qOHN08iQdpA','',1,'FundsIndia',1,205) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-mxHSzCUMfsw','fi-academy','fi-academy-m8','Nippon India Taiwan Equity Fund | FundsIndia360°','video','mxHSzCUMfsw','',2,'FundsIndia',1,206) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-TBNu2ppc1R0','fi-academy','fi-academy-m8','Srikanth Meenakshi on CNBC-TV18 show ''Money Money Money'' - 20-09-2016 - Seg 1','video','TBNu2ppc1R0','',6,'FundsIndia',1,207) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-1geq9qbO5VM','fi-academy','fi-academy-m8','Srikanth Meenakshi on CNBC-TV18 show ''Money Money Money'' - 20-09-2016 - Seg 2','video','1geq9qbO5VM','',7,'FundsIndia',1,208) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-atRblnDOZiU','fi-academy','fi-academy-m8','Srikanth Meenakshi on CNBC-TV18 show ''Money Money Money'' - 20-09-2016 - Seg 3','video','atRblnDOZiU','',8,'FundsIndia',1,209) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Q-j7gWb3Oiw','fi-academy','fi-academy-m8','Srikanth Meenakshi on CNBC-TV18 show ''Money Money Money'' - Seg 1','video','Q-j7gWb3Oiw','',8,'FundsIndia',1,210) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-djSGmY6LIXw','fi-academy','fi-academy-m8','Srikanth Meenakshi on CNBC-TV18 show ''Money Money Money'' - Seg 2','video','djSGmY6LIXw','',5,'FundsIndia',1,211) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-W3TwD2pu40M','fi-academy','fi-academy-m8','Srikanth Meenakshi on CNBC-TV18 show ''Money Money Money'' - Seg 3','video','W3TwD2pu40M','',11,'FundsIndia',1,212) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m9','fi-academy','Customer voices & SIP stories',NULL,9) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-zcktRVNUiMA','fi-academy','fi-academy-m9','Why should you start an SIP? Watch to find out!','video','zcktRVNUiMA','',2,'FundsIndia',1,213) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-UEoksgh9cNM','fi-academy','fi-academy-m9','Wondering why people invest with FundsIndia? Watch to know more.','video','UEoksgh9cNM','',3,'FundsIndia',1,214) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-dh6HlxDv43w','fi-academy','fi-academy-m9','FundsIndia makes investing quick and convenient. Listen to know how!','video','dh6HlxDv43w','',2,'FundsIndia',1,215) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-srvfkOB7Bhc','fi-academy','fi-academy-m9','What makes FundsIndia India''s friendliest investment platform? Watch and find out!','video','srvfkOB7Bhc','',2,'FundsIndia',1,216) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-JNAeGrYhFY4','fi-academy','fi-academy-m9','Is your money safe with FundsIndia? Listen and find out!','video','JNAeGrYhFY4','',2,'FundsIndia',1,217) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ZQpkbJ7IN00','fi-academy','fi-academy-m9','Wondering why people invest with FundsIndia? Watch to know more.','video','ZQpkbJ7IN00','',2,'FundsIndia',1,218) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-qLGoXtFxGuA','fi-academy','fi-academy-m9','Is FundsIndia really that great? Watch to find out!','video','qLGoXtFxGuA','',2,'FundsIndia',1,219) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-uUanCKiDENM','fi-academy','fi-academy-m9','If you have a goal, you should watch this','video','uUanCKiDENM','',3,'FundsIndia',1,220) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-AQ0VwXTXbww','fi-academy','fi-academy-m9','FundsIndia - Customer Voices - Vinit Jawale, Mumbai','video','AQ0VwXTXbww','',1,'FundsIndia',1,221) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-kmaiT2Ws8M0','fi-academy','fi-academy-m9','FundsIndia Sahi Hai! Customer Voices - Srinivas Kottamasu, Bangalore (45 sec)','video','kmaiT2Ws8M0','',1,'FundsIndia',1,222) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-mEZc3yKiCUo','fi-academy','fi-academy-m9','FundsIndia Sahi Hai! Customer Voices - Suman Das, Pune (40 sec)','video','mEZc3yKiCUo','',1,'FundsIndia',1,223) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-zwwP1BCl3oU','fi-academy','fi-academy-m9','FundsIndia Sahi Hai! Customer Voices - Satyajit Das, Pune (34 sec)','video','zwwP1BCl3oU','',1,'FundsIndia',1,224) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('fi-academy-m10','fi-academy','Brand films & campaigns',NULL,10) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ReR6Ac3DyHA','fi-academy','fi-academy-m10','FundsIndia''s Diwali Contest','video','ReR6Ac3DyHA','',1,'FundsIndia',1,225) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-W0LMTJgvmks','fi-academy','fi-academy-m10','How people in your life lighten up your day?','video','W0LMTJgvmks','',2,'FundsIndia',1,226) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-iEk9lIJAsvQ','fi-academy','fi-academy-m10','Thank You and Happy Diwali 2023🪔','video','iEk9lIJAsvQ','',1,'FundsIndia',1,227) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-TeRjm9XIpXI','fi-academy','fi-academy-m10','FundsIndia.com - Make Money (English)','video','TeRjm9XIpXI','',1,'FundsIndia',1,228) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-xTfEULfT3gk','fi-academy','fi-academy-m10','FundsIndia.com - Make Money (Hindi)','video','xTfEULfT3gk','',1,'FundsIndia',1,229) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-qUt91AKHjrI','fi-academy','fi-academy-m10','Fundsindia.com - Save Tax (English)','video','qUt91AKHjrI','',1,'FundsIndia',1,230) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Fw02aodH8fE','fi-academy','fi-academy-m10','FundsIndia.com - Save Tax (Hindi)','video','Fw02aodH8fE','',1,'FundsIndia',1,231) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-aQJWU2xxMLw','fi-academy','fi-academy-m10','Fundsindia.com - Save Tax (English)','video','aQJWU2xxMLw','',1,'FundsIndia',1,232) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-YUJMRj4-p8M','fi-academy','fi-academy-m10','Fundsindia.com - Save Tax (Hindi)','video','YUJMRj4-p8M','',1,'FundsIndia',1,233) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-lny77q0UqRk','fi-academy','fi-academy-m10','FundsIndia.com - Make Money (English - 20 seconds)','video','lny77q0UqRk','',1,'FundsIndia',1,234) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-s_FK9rgc5i8','fi-academy','fi-academy-m10','FundsIndia - Make Money (Hindi - 20 seconds)','video','s_FK9rgc5i8','',1,'FundsIndia',1,235) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-v8lpy1ayXyA','fi-academy','fi-academy-m10','FundsIndia.com - Make Money + Save Tax (Hindi - 20 seconds)','video','v8lpy1ayXyA','',1,'FundsIndia',1,236) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-0PxpY4tbiSE','fi-academy','fi-academy-m10','FundsIndia.com - Make Money + Save Tax (Hindi - 30 seconds)','video','0PxpY4tbiSE','',1,'FundsIndia',1,237) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-vLulDfejzys','fi-academy','fi-academy-m10','FundsIndia''s select Funds','video','vLulDfejzys','',1,'FundsIndia',1,238) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-dvkzfN2Kdyg','fi-academy','fi-academy-m10','Happy Mother’s Day to every mom! 💐❤️','video','dvkzfN2Kdyg','',1,'FundsIndia',1,239) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Zy6oNsStTLo','fi-academy','fi-academy-m10','He Taught You More Than Money—Now It''s Your Turn 💙 | 𝙁𝙖𝙩𝙝𝙚𝙧’𝙨 𝘿𝙖𝙮 Special','video','Zy6oNsStTLo','',1,'FundsIndia',1,240) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-oobO4TcZwic','fi-academy','fi-academy-m10','Right Investment Platform Solves 90% of your worries!','video','oobO4TcZwic','',1,'FundsIndia',1,241) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Q9tJP8_1qZU','fi-academy','fi-academy-m10','2 Coaches. 0 Guesswork. Smarter Investing Starts Here! 📈','video','Q9tJP8_1qZU','',1,'FundsIndia',1,242) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-WGHh3PYdmYo','fi-academy','fi-academy-m10','Turn ₹1 Crore into ₹2.67 Crores in 5 Years? | FundsIndia’s 5-Finger Strategy','video','WGHh3PYdmYo','',1,'FundsIndia',1,243) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-sRz5m6cbQEc','fi-academy','fi-academy-m10','💡 Double-Digit Returns Made Simple! | FundsIndia’s Signature 5-Finger Strategy','video','sRz5m6cbQEc','',1,'FundsIndia',1,244) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-G22a613Oa64','fi-academy','fi-academy-m10','𝗜𝗻𝗱𝗲𝗽𝗲𝗻𝗱𝗲𝗻𝗰𝗲 𝗗𝗮𝘆 𝟮𝟬𝟮𝟱| Celebrate Freedom, Build Your Future 🌟✨','video','G22a613Oa64','',1,'FundsIndia',1,245) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-wpt_XEOLxio','fi-academy','fi-academy-m10','Light Up Your Wealth This Diwali | FundsIndia Wishes You a Prosperous Year Ahead ✨','video','wpt_XEOLxio','',1,'FundsIndia',1,246) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-s9dnbc5Zi_o','fi-academy','fi-academy-m10','Support your Child''s Dream - Open Minor Account Today!','video','s9dnbc5Zi_o','',1,'FundsIndia',1,247) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-_aezsIKv1KA','fi-academy','fi-academy-m10','Add these Stocks to your Watchlist this Festive Season (TRIVIA)','video','_aezsIKv1KA','',1,'FundsIndia',1,248) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-vZiSYBIGooQ','fi-academy','fi-academy-m10','Secure Your Kid''s Future by Investing through @fundsindia !!!With tailored child focused investment','video','vZiSYBIGooQ','',1,'FundsIndia',1,249) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-PxJrmHffsa4','fi-academy','fi-academy-m10','Investments and their adversaries - Explained | FundsIndia | Dussehra','video','PxJrmHffsa4','',2,'FundsIndia',1,250) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9ZIk9QCJB_0','fi-academy','fi-academy-m10','Swadeshi Movement 2.0','video','9ZIk9QCJB_0','',4,'FundsIndia',1,251) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-w0rZ4Ie88wQ','fi-academy','fi-academy-m10','Mother''s Day Special | | Mom - Wow','video','w0rZ4Ie88wQ','',1,'FundsIndia',1,252) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-qfYt1ZXxPec','fi-academy','fi-academy-m10','Mother''s Day Special | FundsIndia | The Ultimate Investors','video','qfYt1ZXxPec','',2,'FundsIndia',1,253) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-UeSp2a4wQgo','fi-academy','fi-academy-m10','FundsIndia | Let the money work for you','video','UeSp2a4wQgo','',1,'FundsIndia',1,254) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-J2eAzNjwiU8','fi-academy','fi-academy-m10','FundsIndia | A hero that doesn''t disappoint','video','J2eAzNjwiU8','',1,'FundsIndia',1,255) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-joy1e5SFDNg','fi-academy','fi-academy-m10','FundsIndia | Your child deserves the best','video','joy1e5SFDNg','',1,'FundsIndia',1,256) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Hg1u8FIHfj0','fi-academy','fi-academy-m10','What is Financial Freedom? Celebrating 75 years of Independence','video','Hg1u8FIHfj0','',4,'FundsIndia',1,257) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-4XtPsd730_I','fi-academy','fi-academy-m10','FundsIndia | Bano Intelligent Investor (English)','video','4XtPsd730_I','',1,'FundsIndia',1,258) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-DbKNMgPYHqM','fi-academy','fi-academy-m10','FundsIndia | Bano Intelligent Investor','video','DbKNMgPYHqM','',1,'FundsIndia',1,259) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-mwWDLNE-Q30','fi-academy','fi-academy-m10','FundsIndia Golden Icon Awards','video','mwWDLNE-Q30','',2,'FundsIndia',1,260) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-eTBn_nAdvfI','fi-academy','fi-academy-m10','Where to invest "Equity or Liquidity"?','video','eTBn_nAdvfI','',1,'FundsIndia',1,261) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-ZJDfkX39ulA','fi-academy','fi-academy-m10','What''s India''s favorite use of the internet?','video','ZJDfkX39ulA','',4,'FundsIndia',1,262) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-cKtDZEDa5Rc','fi-academy','fi-academy-m10','Life Goal (Bumper Video)','video','cKtDZEDa5Rc','',1,'FundsIndia',1,263) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-LnVHSaDlK1w','fi-academy','fi-academy-m10','Celebrate Rakshabandhan with FundsIndia','video','LnVHSaDlK1w','',2,'FundsIndia',1,264) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-w1aEKS1YYd8','fi-academy','fi-academy-m10','SIP vs EMI (Bumper video)','video','w1aEKS1YYd8','',1,'FundsIndia',1,265) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Ebw7hOJ2j8Q','fi-academy','fi-academy-m10','Cut Tax (Bumper Ad)','video','Ebw7hOJ2j8Q','',1,'FundsIndia',1,266) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-5tr7jV_g_AA','fi-academy','fi-academy-m10','FundsIndia - Tablet (Bumper Ad)','video','5tr7jV_g_AA','',1,'FundsIndia',1,267) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-9IKs-IdFJ8s','fi-academy','fi-academy-m10','FundsIndia - App (Bumper Ad)','video','9IKs-IdFJ8s','',1,'FundsIndia',1,268) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-kfxlmQArG28','fi-academy','fi-academy-m10','FundsIndia - Products (Bumper Ad)','video','kfxlmQArG28','',1,'FundsIndia',1,269) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-fJx-YvpsLkA','fi-academy','fi-academy-m10','FundsIndia - Login (Bumper Ad)','video','fJx-YvpsLkA','',1,'FundsIndia',1,270) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-6ANSCTEWc_M','fi-academy','fi-academy-m10','Thank you mom, you''re the best!','video','6ANSCTEWc_M','',2,'FundsIndia',1,271) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-xfN6Zh1hM9M','fi-academy','fi-academy-m10','Don''t know where to invest? Listen to see how FundsIndia can help!','video','xfN6Zh1hM9M','',1,'FundsIndia',1,272) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-Gg0gIwp7Be8','fi-academy','fi-academy-m10','FundsIndia makes investing easier. Watch to know how!','video','Gg0gIwp7Be8','',1,'FundsIndia',1,273) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-fxgzFiEJxQI','fi-academy','fi-academy-m10','How to get higher returns!','video','fxgzFiEJxQI','',1,'FundsIndia',1,274) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-6RbfCgUiqMM','fi-academy','fi-academy-m10','The FundsIndia Story','video','6RbfCgUiqMM','',2,'FundsIndia',1,275) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('fi-academy-v-h88a8R0k76Q','fi-academy','fi-academy-m10','Meet your friendly new robo advisor - Money Mitr','video','h88a8R0k76Q','',2,'FundsIndia',1,276) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
UPDATE courses SET hours = 24.7 WHERE id = 'fi-academy';
INSERT INTO courses (id,code,title,subtitle,category,description,level,hours,playlists,links,published,popular,sort) VALUES ('nism-5a','NISM V-A','NISM Series V-A','Mutual Fund Distributors Certification','nism','The mandatory certification for mutual fund distributors. Chapter-wise video lessons from the full V-A course playlist, chapter summary notes from the September 2026 workbook, chapter practice, 20 full mock tests and a final assessment.','Mandatory (AMFI ARN)',0,'[]','[{"title":"NISM - certification & exam information","url":"https://www.nism.ac.in/certification/"},{"title":"NISM - official workbooks","url":"https://www.nism.ac.in/publication/"}]',1,1,1) ON CONFLICT(id) DO UPDATE SET code=excluded.code,title=excluded.title,subtitle=excluded.subtitle,category=excluded.category,description=excluded.description,level=excluded.level,hours=excluded.hours,playlists=excluded.playlists,links=excluded.links,published=excluded.published,popular=excluded.popular,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m0','nism-5a','Start here: exam overview',NULL,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l0','nism-5a','nism-5a-m0','Exam pattern & syllabus weightage (September 2026 workbook)','note','## NISM Series V-A: Mutual Fund Distributors

- Complete chapter-by-chapter summary of the NISM workbook (September 2026 version) – 12 chapters + appendices

- **100**
- questions · 2 hrs

- Valid for exams on or after 20 Nov 2026

## Exam Pattern and Syllabus Weightage

- questions, 1 mark each

- **2 hrs**

- duration

- **50%**

- passing score

- **Nil**

- negative marking

- Test centres use MS Excel or LibreOffice Calc for numericals',6,1,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-kTSSHzaUsTw','nism-5a','nism-5a-m0','Video lesson: 2026 Updates','video','kTSSHzaUsTw','',50,'N V Finance',1,1) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m1','nism-5a','Ch 1: Investment Landscape',8,1) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-D4PqE1whQOw','nism-5a','nism-5a-m1','Video lesson: Chapter 1: Mutual Fund Basics Explained','video','D4PqE1whQOw','',45,'N V Finance',1,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l3','nism-5a','nism-5a-m1','Summary notes 1/4: Financial Goals and How to Classify Them to Asset Classes: Real Estate & Commodities','note','## Financial Goals and How to Classify Them

- **Investors and Financial Goals**

- Start with "Why" – discuss the investor''s purpose, not just products
- Financial objective + amount + timeline = Financial goal
- **Common goals:** child education, marriage, retirement, house, vehicle, vacation
- **Uncommon goals:** own business, sabbatical, higher studies
- Undesirable events (death, hospitalisation, accident, fire) → emergency fund + insurance, not investment
- **Steps:** identify life events → prioritise → assign timeline & amount

- **Classifying Goals:** Time & Importance

- **Importance:** Critically important (needs) · Dreams · Good-to-have
- **Timeline:** Immediate · Near · Medium · Long term
- Retirement = accumulation phase + income (withdrawal) phase
- **Covey''s Time Management Matrix:** urgent vs important quadrants
- Plan the "important but not urgent" goals early – else they become urgent crises

## Inflation and the Pool Approach

- Inflation raises the future cost of goals – always inflation-adjust goal values
- Education & healthcare costs rise fastest
- **Example:** ₹50 lakh education today @8% for 10 yrs ≈ ₹1.08 crore
- ₹30,000 monthly expenses @6% → ₹53,725 in 10 yrs; ₹96,214 in 20 yrs
- **Pool approach:** one common corpus for all needs – drawback: horizon unknown
- All goals share a cash-flow mismatch → need to save and invest early

## Saving vs Investing

- Saving = safety of money / reducing consumption; Investing = aim to earn profit
- Saving precedes investing – two steps of the same process
- Risk–return trade-off applies to investing

| Factor | What to evaluate |
| --- | --- |
| Safety | Safety of capital and surety of income |
| Liquidity | Ease of converting to cash; lock-in, exit penalty, divisibility |
| Returns | Current income (periodic) + capital appreciation (on sale) |
| Convenience | Ease of investing, withdrawing, tracking value |
| Ticket size | Minimum investment (₹50 to ₹1 crore+) |
| Taxability | Post-tax return matters; may depend on holding period |
| Tax deduction | Raises effective return; often comes with lock-in |

## Asset Classes: Real Estate & Commodities

- Asset class = group of investments with similar characteristics
- **Four broad classes:** Real estate, Commodities, Fixed income, Equity
- **Real estate:** location is key; illiquid; not divisible; rent + capital gains
  - High transaction & maintenance costs; self-occupied home is not an investment
- **Commodities:** most are perishable/bulky; derivatives are leveraged & short-term
  - **Gold & silver:** globally priced, store of value, "safe haven"
  - No current income – only capital appreciation; purity risk in physical form',12,1,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l4','nism-5a','nism-5a-m1','Summary notes 2/4: Asset Classes: Fixed Income & Equity to Investment Risks (2/2)','note','## Asset Classes: Fixed Income & Equity

- **Fixed income:** lending via bonds/debentures; issuers – Govt, companies, banks, PSUs
  - Regular interest; held to maturity → usually no capital gain
  - Classified by issuer (Govt/corporate) or maturity (short/medium/long)
- **Equity:** owner''s capital – risk capital linked to business fortunes
  - Beats inflation over long periods; Sensex 100 (1979) → 82,269 (Jan 2026) ≈ 15.4% p.a.
  - Dividends + capital appreciation; volatile short-term, follows profits long-term
- **Equity & bonds:** financial form only; real estate & commodities: physical or financial
- Ownership assets (uncertain cash flows) vs lending assets (agreed cash flows)
- International assets add currency exposure

## Investment Avenues by Asset Class

| Asset class | Examples |
| --- | --- |
| Equity | Blue-chip, mid & small caps, unlisted, foreign stocks, equity MFs, ETFs, index funds |
| Fixed income | Bank FD/RD, endowment & money-back policies, PPF, SSY, SCSS, POMIS, PO RD, company FD, bonds, debt MFs |
| Commodities | Gold, silver, gold funds, commodity ETFs |
| Real estate | Physical: residential/commercial; Financial: REMF, REIT, InvIT |
| Hybrid | Hybrid / multi-asset funds |
| Others | Rare coins, art, rare stamps |

## Investment Risks (1/2)

- **Inflation risk:** erodes purchasing power
  - ₹10,000 @8% → ₹14,693 (5 yr), ₹21,589 (10 yr), ₹46,610 (20 yr), ₹1,00,627 (30 yr)
  - Nominal return vs Real return (inflation-adjusted); FD 7% vs inflation 8% = negative real
- **Liquidity risk:** early exit penalty, lock-in (PPF), slow sale (real estate)
  - Equity is liquid but volatile – not for short-term needs
- **Credit risk:** delay or default in interest/principal
  - Depends on borrower''s ability and intention; lower safety → higher interest
  - Own government bonds = safest, lowest yield

## Investment Risks (2/2)

- Market risk vs price (specific) risk
  - **Market-wide:** war fears, economy; Industry-specific: policy, technology (pagers vs mobiles)
  - **Company-specific:** product failure – reducible by diversification
- **Interest rate risk:** bond prices move inversely to interest rates
  - Rates ↑ → existing bond prices ↓ (and vice versa)
  - Longer maturity → higher price sensitivity
  - Market-wide factor affecting all bonds',12,1,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l5','nism-5a','nism-5a-m1','Summary notes 3/4: Risk Management Strategies to Asset Allocation','note','## Risk Management Strategies

- **Avoid:** skip products you don''t understand (also gives up opportunity)
- **Take a position:** e.g. buy long bonds expecting rate fall – needs superior skill, risky
- **Diversify:** prudent for lay investors

| Systematic (market-wide) | Unsystematic (specific) |
| --- | --- |
| Cannot be diversified away | Reduced by diversification |
| Inflation, interest rate, market risk | Credit risk, liquidity risk, company price risk |

- **Measuring risk:** credit rating & credit spreads; variance, SD, beta, modified duration (Ch 10)

## Behavioural Biases

- **Dominant emotions:** fear, greed, hope
- **Availability heuristic:** relying on what comes to mind first
- **Confirmation bias:** seeking data that supports existing views
- **Familiarity bias:** preferring the known → poor diversification
- **Herd mentality:** following the crowd
- **Loss aversion:** pain of loss > joy of equal gain (Kahneman & Tversky)
- **Overconfidence:** overrating own skill → unassessed risks
- **Recency bias:** extrapolating recent events (bull/bear markets)
- **Also:** behaviour patterns, investor''s interests (concentration), ethical standards
- **Remedy:** take a third-party opinion – RIA or MFD

## Risk Profiling

- **Purpose:** avoid selling schemes riskier than the investor can handle
- Three elements of risk appetite:
  - Risk required – need to take risk to reach goals
  - Risk capacity – financial ability and investment horizon
  - Risk tolerance – psychological willingness
- Distributor balances the three when they conflict
- Distributor may choose/design own risk-profiling tools

## Asset Allocation

- Process of allocating money across asset classes in line with a stated objective
- **Strategic (SAA):** target mix based on goals, horizon and risk profile
- **Tactical (TAA / dynamic):** changes mix to exploit opportunities; improve risk-adjusted return – for seasoned investors
- Rebalancing restores the target → "buy low, sell high" automatically
  - Example 50:50 → A +20%, B −5% → 55.81:44.19 → sell ₹125 of A, buy B
  - Also rebalance when investor''s situation changes
- **SEBI:** passive breach rebalancing within 30 business days (not for index funds/ETFs; not applicable to overnight funds)',12,1,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l6','nism-5a','nism-5a-m1','Summary notes 4/4: Do-it-Yourself vs Professional Help','note','## Do-it-Yourself vs Professional Help

- A mutual fund changes the way of investing – job outsourced to professionals (AMC)
- Ask three questions:
  - Can I do it? (skill + time)
  - Do I want to do it?
  - Can I afford to outsource?
- **Hidden costs of DIY:** value of one''s time + emotional mistakes
- **Example:** 2% fee on ₹10 lakh = ₹20,000/yr – compare with time & effort
- For most investors, mutual funds are the better option',3,1,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z0','nism-5a','nism-5a-m1','Chapter 1 practice',30,50,0,0,0,1,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q0','nism-5a-z0','Real return is:','["Return before expenses","Return on a real-estate investment","Return net of tax only","Nominal return adjusted for inflation"]',3,'FD 7% with 8% inflation gives a negative real return.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q1','nism-5a-z0','Allocation that sets a long-term target mix based on goals, horizon and risk profile is:','["Tactical asset allocation","Strategic asset allocation","Market timing","Dynamic hedging"]',1,'SAA sets the target; TAA changes the mix to exploit opportunities.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q2','nism-5a-z0','A self-occupied home is NOT generally treated as an investment because:','["It does not generate income or capital gains for the owner to realise","It is exempt from asset allocation","It cannot be mortgaged","It is always illiquid and therefore illegal as an asset"]',0,'The workbook states a self-occupied home is not an investment.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q3','nism-5a-z0','The three elements of risk appetite are:','["Risk required, risk capacity and risk tolerance","Credit risk, market risk and liquidity risk","Risk avoidance, risk transfer and risk sharing","Risk return, risk rating and risk reward"]',0,'The distributor balances required, capacity and tolerance when they conflict.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q4','nism-5a-z0','Ownership assets differ from lending assets in that ownership assets have:','["Guaranteed maturity value","Uncertain cash flows","No risk","Agreed cash flows"]',1,'Equity and real estate = ownership (uncertain); bonds = lending (agreed).',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q5','nism-5a-z0','When interest rates rise, the prices of existing bonds:','["Fall","Stay unchanged","Rise","Become equal to face value"]',0,'Bond prices move inversely to interest rates.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q6','nism-5a-z0','A portfolio of ₹30,00,000 is 40:60 equity:debt. Equity rises 10% and debt is unchanged. To rebalance to the original ratio, the amount of equity to be sold is:','["₹1,08,000","₹1,20,000","₹72,000","₹3,00,000"]',2,'New equity = 1320000; target = 1248000; sell the excess.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q7','nism-5a-z0','A goal costs ₹79,000 today. With inflation of 7% p.a., its cost after 10 years will be approximately:','["₹1,55,405","₹1,66,283","₹1,34,300","₹1,45,238"]',0,'FV = 79000 × (1 + 7%)^10.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q8','nism-5a-z0','A portfolio of ₹4,00,000 is 70:30 equity:debt. Equity rises 10% and debt is unchanged. To rebalance to the original ratio, the amount of equity to be sold is:','["₹40,000","₹28,000","₹12,600","₹8,400"]',3,'New equity = 308000; target = 299600; sell the excess.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q9','nism-5a-z0','Under SEBI norms, a passive breach of asset allocation must be rebalanced within:','["30 business days","10 business days","1 year","90 calendar days"]',0,'Passive breach rebalancing is allowed within 30 business days (not for index funds/ETFs).',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q10','nism-5a-z0','The behavioural bias in which the pain of a loss is felt more than the joy of an equal gain is:','["Recency bias","Herd mentality","Familiarity bias","Loss aversion"]',3,'Loss aversion was described by Kahneman and Tversky.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q11','nism-5a-z0','The main drawback of the "pool approach" to goal funding is that:','["It cannot be used for mutual funds","The time horizon for each goal is unknown","It ignores inflation completely","It requires a demat account"]',1,'One common corpus for all needs hides the horizon of each individual goal.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q12','nism-5a-z0','A portfolio of ₹7,00,000 is 60:40 equity:debt. Equity rises 10% and debt is unchanged. To rebalance to the original ratio, the amount of equity to be sold is:','["₹25,200","₹42,000","₹16,800","₹70,000"]',2,'New equity = 462000; target = 445200; sell the excess.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q13','nism-5a-z0','A goal costs ₹63,000 today. With inflation of 7% p.a., its cost after 6 years will be approximately:','["₹89,460","₹94,546","₹88,361","₹1,01,164"]',1,'FV = 63000 × (1 + 7%)^6.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q14','nism-5a-z0','A goal costs ₹68,000 today. With inflation of 5% p.a., its cost after 9 years will be approximately:','["₹98,600","₹1,05,490","₹1,00,467","₹1,10,765"]',1,'FV = 68000 × (1 + 5%)^9.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q15','nism-5a-z0','"Risk capacity" of an investor refers to:','["Risk needed to reach goals","Risk rating of the scheme","Psychological willingness to take risk","Financial ability and investment horizon"]',3,'Risk tolerance is psychological; risk capacity is financial ability and horizon.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q16','nism-5a-z0','A goal costs ₹54,000 today. With inflation of 5% p.a., its cost after 7 years will be approximately:','["₹72,900","₹72,365","₹79,783","₹75,983"]',3,'FV = 54000 × (1 + 5%)^7.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q17','nism-5a-z0','Which bonds are MOST sensitive to a change in interest rates?','["Overnight instruments","Shorter-maturity bonds","Longer-maturity bonds","Bank savings deposits"]',2,'Longer maturity means higher price sensitivity.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q18','nism-5a-z0','An investor extrapolating the recent bull-market performance into the future is showing:','["Confirmation bias","Availability of liquidity","Recency bias","Loss aversion"]',2,'Recency bias is extrapolating recent events.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q19','nism-5a-z0','Which asset class gives no current income, only capital appreciation?','["Dividend-paying equity","Rent-yielding real estate","Gold and silver","Bonds"]',2,'Gold and silver pay no periodic income.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q20','nism-5a-z0','Restoring the target asset mix after market movements is called:','["Tactical drift","Averaging","Rebalancing","Switching"]',2,'Rebalancing automatically results in "buy low, sell high".',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q21','nism-5a-z0','A portfolio of ₹22,00,000 is 50:50 equity:debt. Equity rises 15% and debt is unchanged. To rebalance to the original ratio, the amount of equity to be sold is:','["₹1,23,750","₹1,65,000","₹82,500","₹3,30,000"]',2,'New equity = 1265000; target = 1182500; sell the excess.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q22','nism-5a-z0','Which of the following is an unsystematic (specific) risk?','["Inflation risk","Interest rate risk","Market-wide risk","Credit risk"]',3,'Credit, liquidity and company-specific price risk can be reduced by diversification; inflation, interest-rate and market risk cannot.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q23','nism-5a-z0','Retirement planning has two phases. They are:','["Accumulation phase and income (withdrawal) phase","Saving phase and lock-in phase","Growth phase and exit-load phase","Pre-tax phase and post-tax phase"]',0,'Retirement = accumulation phase + income (withdrawal) phase.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z0-q24','nism-5a-z0','A goal costs ₹86,000 today. With inflation of 6% p.a., its cost after 5 years will be approximately:','["₹1,11,800","₹1,08,573","₹1,15,087","₹1,21,993"]',2,'FV = 86000 × (1 + 6%)^5.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m2','nism-5a','Ch 2: Concept and Role of a Mutual Fund',6,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-BJWh2ncpLlA','nism-5a','nism-5a-m2','Video lesson: Chapter 2: Concept and Role of Mutual Funds','video','BJWh2ncpLlA','',51,'N V Finance',1,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l8','nism-5a','nism-5a-m2','Summary notes 1/6: What a Mutual Fund Is and the Role It Plays to Advantages of Mutual Funds (1/2)','note','## What a Mutual Fund Is and the Role It Plays

- **What is a Mutual Fund**

- Professionally managed investment vehicle, set up as a trust
- One invests "through" a mutual fund, not "in" it – a different way of investing, not a different product
- Gives access to equities, bonds, money market & other securities
- **Key differences:** professional management, diversification, regulated vehicle
- ''Fund'' and ''scheme'' used interchangeably in the industry

- **Role of Mutual Funds**

- Help investors earn income or build wealth from securities markets
- Channel savings to governments & companies → projects, jobs, growth
- Large investor → checks on corporate governance of investee companies
- Livelihood for AMC staff, distributors, registrars, service providers
- Higher output & tax revenue → nation-building
- **Market stabiliser:** countered heavy FPI selling in 2022 and 2025

## Investment Objective & Policy

- Each scheme = separate pool with a pre-announced investment objective
- Objectives combine safety, liquidity and returns

| Objective (example) | Category |
| --- | --- |
| Reasonable income + high liquidity; debt/money market up to 91 days | Liquid fund |
| Capital appreciation from equity | Equity fund |
| Long-term growth via equity, debt, InvITs, commodities | Hybrid fund |
| Goal-based investing with glide path & set maturity | Life Cycle fund |

- Profits/losses belong only to unitholders; others earn fees
- Investment policy = asset allocation + investment style (growth/value, focused/diversified), disclosed in SID

## Key Concepts

| Term | Meaning |
| --- | --- |
| Units | Investment translated into units of the scheme |
| Face value | Usually ₹10 (can be ₹100); accounting relevance |
| Unit capital | Units issued × face value |
| Recurring expenses | Fees charged as % of AUM; reduce NAV; capped by SEBI |
| NAV | True worth per unit; net realisable value if liquidated |
| AUM | Total scheme size = NAV × units outstanding |
| Mark to Market | Daily valuation of each security at current market value |

- AUM rises with performance & inflows; falls with redemptions & IDCW payouts
- Dividend option now called IDCW (Income Distribution cum Capital Withdrawal)

## Advantages of Mutual Funds (1/2)

- **Professional management:** research, prudent process, admin (corporate actions), daily accounting
- **Affordable diversification:** from ₹500 – "not all eggs in one basket"
- **Economies of scale:** shared research & office costs; better broker terms
- **Transparency:** SID, SAI, KIM, factsheets/portfolio disclosures, daily NAV – even for prospects
- **Liquidity:** redeem with fund; close-ended units listed on exchange; small ticket access to wholesale bond market',12,1,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l9','nism-5a','nism-5a-m2','Summary notes 2/6: Advantages of Mutual Funds (2/2) to Exchange Traded Funds (ETFs)','note','## Advantages of Mutual Funds (2/2)

- **Tax deferral:** fund pays no tax; growth option lets wealth compound
- **Tax benefit:** ELSS – deduction up to ₹1,50,000 under Sec 80C (Old Tax Regime)
- **Convenient options:** partial withdrawal, additional purchase, IDCW/growth
- **Investment comfort:** minimal paperwork for further investments
- **Regulatory comfort:** SEBI checks and balances
- **Systematic approach:** SIP, SWP, STP build investment discipline

## Limitations of Mutual Funds

- No portfolio customisation (unlike PMS)
- Choice overload – addressed by SEBI categorisation & distributors
- No control over costs – shared by all; SEBI caps expenses
- No guaranteed returns – pass-through vehicle; depends on market, securities and manager skill

## Classification by Structure

| Type | Key features |
| --- | --- |
| Open-ended | Buy/redeem any time after NFO; no maturity; unit capital keeps changing |
| Close-ended | Buy only in NFO; fixed maturity; compulsorily listed (except ELSS); unit capital fixed; trades usually at discount to NAV |
| Interval | Mostly close-ended, open in transaction periods; listed |

- **Interval fund:** transaction period min 2 days; interval period min 15 calendar days
- Redemption only during transaction period

## Exchange Traded Funds (ETFs)

- Traded on stock exchange like a share throughout the day
- Usually passive – track an index
- Multiple intra-day prices vs single end-of-day NAV for open-ended funds
- Market price tracks NAV closely, but gaps possible – watch the price
- Needs demat account; small minimum investment
- Gold ETF and Silver ETF (invests mainly in silver/silver instruments)',12,1,9) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l10','nism-5a','nism-5a-m2','Summary notes 3/6: Active vs Passive; Investment Universe to Equity Schemes (2/2)','note','## Active vs Passive; Investment Universe

- **Active funds:** manager chooses portfolio; higher costs; aim to beat the market
- **Passive / index funds:** replicate index composition & weights; low cost; mirror the index
- MF Lite framework (Chapter X, SEBI MF Regulations 2026): mutual funds with only index funds, ETFs, FoFs & other specified passive schemes
- **By investment universe:** equity, fixed income, money market, gold, international
  - **Narrower:** large-cap / mid-cap; G-sec / corporate debt

## SEBI Scheme Categorisation

- **Purpose:** uniformity among similar schemes across fund houses
- Five broad categories:
  - A. Equity – 13 sub-categories
  - B. Debt – 17 sub-categories
  - C. Hybrid – 7 sub-categories
  - D. Life Cycle Funds
  - E. Other – 2 sub-categories
- Market cap definition (full market cap ranking):
  - **Large cap:** 1st–100th · Mid cap: 101st–250th · Small cap: 251st onwards

## Equity Schemes (1/2)

| Scheme | Minimum equity rule |
| --- | --- |
| Multi Cap | ≥75% equity; ≥25% each in large, mid, small |
| Large Cap | ≥80% in large caps |
| Large & Mid Cap | ≥35% large + ≥35% mid |
| Mid Cap | ≥65% in mid caps |
| Small Cap | ≥65% in small caps |
| Flexi Cap | ≥65% equity; dynamic across market caps |
| Dividend Yield | ≥80% equity; dividend-yielding stocks |

## Equity Schemes (2/2)

| Scheme | Rule |
| --- | --- |
| Value | ≥80% equity; value strategy |
| Contra | ≥80% equity; contrarian; Value & Contra overlap ≤50% |
| Focused | Max 30 stocks; ≥80% equity; state focus (multi/large/mid/small) |
| Sectoral | ≥80% in one sector (e.g. banks, power) |
| Thematic | ≥80% in a theme (e.g. infrastructure) |
| ELSS – Tax Saver | ≥80% equity; 3-year statutory lock-in; tax benefit |

- **Sectoral/thematic:** ≤50% portfolio overlap with other equity schemes (except large cap)
- **Residual:** money market, gold/silver instruments, InvITs within limits',12,1,10) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l11','nism-5a','nism-5a-m2','Summary notes 4/6: Debt Schemes (1/2) to Life Cycle Funds & Other Schemes','note','## Debt Schemes (1/2)

| Scheme | Rule |
| --- | --- |
| Overnight | 1-day maturity securities |
| Liquid | Maturity up to 91 days |
| Ultra-Short Term | Macaulay duration 3–6 months |
| Ultra Short to Short Term | Macaulay duration 6–12 months |
| Money Market | Money market instruments up to 1 year |
| Short Term | Macaulay duration 1–3 years |
| Medium Term | 3–4 years (1–4 yrs in adverse situation) |
| Medium to Long Term | 4–7 years (1–7 yrs in adverse situation) |
| Long Term | Macaulay duration > 7 years |

## Debt Schemes (2/2)

| Scheme | Rule |
| --- | --- |
| Dynamic Term | Across duration |
| Corporate Bond | ≥80% in AA+ & above corporate bonds |
| Credit Risk | ≥65% in AA & below (excl. AA+) |
| Banking & PSU | ≥80% in banks, PSUs, PFIs, municipal bonds |
| Gilt | ≥80% G-secs across maturity |
| Gilt 10-yr Constant Maturity | ≥80% G-secs; duration = 10 years |
| Floater | ≥65% floating-rate instruments (incl. swaps) |
| Sectoral Debt | ≥80% in one sector, AA+ & above (Financial services, Energy, Infra, Housing, Real Estate) |

- Overnight funds may place ≤5% in G-secs/T-bills (≤30 days) as margin
- Names must not highlight only returns (e.g. "high yield")

## Hybrid Schemes

| Scheme | Allocation |
| --- | --- |
| Conservative Hybrid | Debt 75–90%; Equity 10–25% |
| Balanced Hybrid | Equity 40–60%; Debt 40–60%; no arbitrage |
| Aggressive Hybrid | Equity 65–80%; Debt 20–35% |
| Balanced Advantage / Dynamic AA | Equity/debt managed dynamically |
| Multi Asset Allocation | ≥3 asset classes, ≥10% each; foreign not separate class |
| Arbitrage | ≥65% equity; debt only G-secs <1 yr & G-sec repo |
| Equity Savings | ≥65% equity, ≥10% debt; net equity 15–40% |

- **Residual (except arbitrage):** InvITs, ETCDs, Gold & Silver ETFs

## Life Cycle Funds & Other Schemes

- **Life Cycle Fund:** glide-path investing across equity, debt, InvITs, ETCDs, gold & silver ETFs
  - Tenure 5–30 years, in multiples of 5; max 6 active for subscription; maturity in name (e.g. Life Cycle Fund 2055)
  - Equity reduces, debt rises as maturity approaches
  - Children''s Fund kept → no 20-yr LCF; Retirement Fund kept → no 30-yr LCF; both kept → only 5/10/15/25-yr
- **Index Funds/ETFs:** ≥95% in index securities
- **Fund of Funds (domestic/overseas):** ≥95% in underlying fund
- One scheme per category, except index funds/ETFs (different indices), FoFs (different underlying), sector/thematic (different sectors)',12,1,11) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l12','nism-5a','nism-5a-m2','Summary notes 5/6: Other Fund Types to Specialized Investment Fund (SIF)','note','## Other Fund Types

- **Fixed Maturity Plans:** close-ended debt; portfolio matched to maturity → clearer likely returns (not guaranteed)
- **Target Maturity Funds:** fixed maturity (2–14 yrs); bonds of matching maturity; low reinvestment risk; listed
- **Capital Protection Oriented:** close-ended hybrid; e.g. ₹90 in debt grows to ₹100; rest in equity derivatives
- **Infrastructure Debt Funds:** close-ended; ≥90% in infra debt; sponsored by banks/NBFCs (trust → MF/SEBI; company → NBFC/RBI)
- **Real Estate MF:** close-ended, listed
- **ESG funds (thematic):** exclusion, integration, best-in-class/positive screening, impact, sustainable objectives, transition

## REITs and InvITs

| Feature | REIT | InvIT |
| --- | --- | --- |
| Invests in | Commercial real estate | Infrastructure |
| Min asset value | ₹500 crore | ₹500 crore |
| Min offer size | ₹250 crore | ₹250 crore |
| Min subscription | ₹10,000–15,000 (earlier ₹50,000) | ₹10,000–15,000 (earlier ₹1 lakh) |
| Trading lot | 1 unit, listed | 1 unit, listed |

- Registered with SEBI, but not mutual fund schemes

## New Types of Funds

- **Factor funds:** Value, Size, Momentum, Low volatility, Quality, Dividend yield – factor performance rotates; often via ETFs
- **Smart Beta:** index variant with alternative weights (e.g. equal weight) – aim better return, diversification, lower risk
- **Quant funds:** model/data-driven, machine-based security selection
- **International REIT funds:** global + commercial real estate exposure

## Specialized Investment Fund (SIF)

- Bridges the gap between MFs and PMS; minimum ₹10 lakh per investor across an AMC''s SIF strategies
- **Equity:** Long-Short (≥80% equity), Ex-Top 100 Long-Short (≥65% outside top 100), Sector Rotation Long-Short (≥80%, max 4 sectors)
  - Open-ended/interval; redemption daily or less frequent
- **Debt:** Debt Long-Short, Sectoral Debt Long-Short (≥2 sectors, max 75% per sector) – interval; weekly redemption or less
- **Hybrid:** Active Asset Allocator Long-Short, Hybrid Long-Short (≥25% each equity & debt) – interval; twice a week or less
- **Max unhedged short exposure:** 25% of NAV; only one strategy per category
- Close-ended/interval SIF strategies must be listed',12,1,12) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l13','nism-5a','nism-5a-m2','Summary notes 6/6: Growth of the MF Industry in India','note','## Growth of the MF Industry in India

- **AUM:** ₹12.33 lakh crore (Mar 2016) → ₹79.46 lakh crore (Mar 2026) – 20.48% CAGR
- **Folios:** ~4.8 crore (Mar 2010) → 27.39 crore (Mar 2026)
- MF share of household financial investment: 10% (2016) → 14% (2018); bank deposits 71% → 65%
- **India''s share of global MF industry:** 0.33% (2008) → 0.60% (2018)
- **Monthly SIP:** ₹8,055 cr (Mar 2019) → ₹32,087 cr (Mar 2026); SIP AUM ₹15.11 lakh crore',3,1,13) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z1','nism-5a','nism-5a-m2','Chapter 2 practice',64,50,0,0,0,1,1) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q0','nism-5a-z1','Close-ended schemes (other than ELSS) must be:','["Priced at exit load","Compulsorily listed on a stock exchange","Open for redemption daily","Managed passively"]',1,'ELSS is the exception to compulsory listing.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q1','nism-5a-z1','A Liquid fund invests in debt and money market securities with maturity up to:','["91 days","180 days","1 year","30 days"]',0,'Liquid = up to 91 days.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q2','nism-5a-z1','Value and Contra funds in the same AMC can have an overlap of at most:','["50%","80%","100%","25%"]',0,'Value & Contra overlap ≤50%.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q3','nism-5a-z1','A Floater fund must invest at least ___ in floating-rate instruments (including swaps).','["75%","90%","65%","80%"]',2,'Floater ≥65% floating rate instruments.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q4','nism-5a-z1','An Arbitrage fund must hold at least ___ in equity.','["65%","75%","80%","35%"]',0,'Arbitrage: ≥65% equity; debt only G-secs <1 yr and G-sec repo.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q5','nism-5a-z1','Aggressive Hybrid funds hold equity of:','["65–80%","≥80%","10–25%","40–60%"]',0,'Aggressive hybrid: equity 65–80%; debt 20–35%.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q6','nism-5a-z1','In India, a mutual fund is set up as a:','["Partnership firm","Company","Trust","Co-operative society"]',2,'A mutual fund is a trust governed by the Indian Trusts Act, 1882.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q7','nism-5a-z1','Under SEBI categorisation, a Large Cap is defined as companies ranked:','["1st to 250th","1st to 50th","1st to 100th by full market capitalisation","101st to 250th"]',2,'Large 1–100; Mid 101–250; Small 251 onwards.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q8','nism-5a-z1','A Mid Cap company is one ranked:','["101st to 250th by full market capitalisation","1st to 100th","51st to 150th","251st onwards"]',0,'Mid cap = 101st–250th.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q9','nism-5a-z1','A Long Duration fund has a Macaulay duration of:','["1 to 3 years","3 to 4 years","4 to 7 years","More than 7 years"]',3,'Long term = Macaulay duration > 7 years.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q10','nism-5a-z1','A Multi Cap fund must invest at least ___ in equity and at least ___ each in large, mid and small caps.','["65%; 15%","80%; 20%","70%; 10%","75%; 25%"]',3,'Multi cap: ≥75% equity; ≥25% in each of large, mid and small.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q11','nism-5a-z1','Conservative Hybrid funds hold debt of:','["75–90% and equity 10–25%","40–60% each","65–80% equity","≥65% equity and ≥10% debt"]',0,'Conservative hybrid: debt 75–90%; equity 10–25%.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q12','nism-5a-z1','The usual face value of a mutual fund unit is:','["₹1","₹1,000","₹10","₹50"]',2,'Face value is usually ₹10 (can be ₹100).',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q13','nism-5a-z1','The Macaulay duration of a Short Term fund portfolio is:','["3 to 4 years","1 to 3 years","4 to 7 years","Above 7 years"]',1,'Short term 1–3 years; Medium 3–4; Medium to Long 4–7; Long >7.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q14','nism-5a-z1','A Flexi Cap fund must invest at least ___ in equity.','["80%","65%","90%","75%"]',1,'Flexi cap: ≥65% equity; dynamic across market caps.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q15','nism-5a-z1','The Trust Deed of a mutual fund must be registered under the:','["Banking Regulation Act, 1949","Indian Registration Act, 1908","Companies Act, 2013","Insurance Act, 1938"]',1,'The Trust Deed is registered under the Indian Registration Act, 1908.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q16','nism-5a-z1','SEBI categorisation of schemes has how many broad categories?','["Five (Equity, Debt, Hybrid, Life Cycle, Other)","Three","Four","Seven"]',0,'Equity – 13, Debt – 17, Hybrid – 7, Life Cycle Funds, Other – 2 sub-categories.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q17','nism-5a-z1','An "Equity Long-Short" SIF strategy must invest at least ___ in equity.','["95%","80%","65%","50%"]',1,'Equity Long-Short ≥80%; Ex-Top 100 Long-Short ≥65% outside the top 100.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q18','nism-5a-z1','The dividend option in mutual funds is now called:','["CAS","SWP","DDT","IDCW"]',3,'IDCW = Income Distribution cum Capital Withdrawal.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q19','nism-5a-z1','A Fixed Maturity Plan is:','["A hybrid scheme with a glide path","An ETF on gold","An open-ended equity scheme","A close-ended debt scheme with a portfolio matched to maturity"]',3,'FMP returns are not guaranteed, only clearer.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q20','nism-5a-z1','A Banking & PSU fund must invest at least ___ in debt of banks, PSUs, PFIs and municipal bonds.','["90%","80%","75%","65%"]',1,'Banking & PSU ≥80%.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q21','nism-5a-z1','The tenure of a Life Cycle Fund is:','["5 to 30 years in multiples of 5","Perpetual","1 to 5 years","3 to 15 years"]',0,'Max 6 active LCFs open for subscription; maturity year in the name.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q22','nism-5a-z1','A Gilt fund must invest at least ___ in G-secs across maturities.','["75%","90%","80%","65%"]',2,'Gilt ≥80%; Gilt 10-year constant maturity has duration of 10 years.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q23','nism-5a-z1','A Multi Asset Allocation fund invests in at least ___ asset classes with a minimum of ___ in each.','["Three; 25%","Three; 10%","Four; 5%","Two; 20%"]',1,'Foreign securities are not a separate asset class.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q24','nism-5a-z1','A Corporate Bond fund must invest at least ___ in corporate bonds rated AA+ and above.','["75%","80%","90%","65%"]',1,'Corporate bond ≥80% in AA+ and above.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q25','nism-5a-z1','Investors "invest through" a mutual fund. This means a mutual fund is:','["A vehicle, not a separate product","An insurance policy","A guaranteed return product","A bank deposit"]',0,'It is a different way of investing, not a different product.',25) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q26','nism-5a-z1','The minimum asset value for a REIT or InvIT at registration is:','["₹100 crore","₹500 crore","₹250 crore","₹1,000 crore"]',1,'Min asset value ₹500 crore; min offer size ₹250 crore.',26) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q27','nism-5a-z1','A Large Cap fund must invest at least ___ of total assets in large cap stocks.','["75%","65%","80%","90%"]',2,'Large cap: ≥80% in large caps.',27) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q28','nism-5a-z1','A Mid Cap fund must invest at least ___ in mid cap stocks.','["65%","35%","80%","75%"]',0,'Mid cap ≥65%; same for small cap.',28) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q29','nism-5a-z1','Sectoral/thematic funds can have portfolio overlap with other equity schemes (other than large cap) of at most:','["75%","50%","25%","10%"]',1,'Overlap limit is 50%.',29) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q30','nism-5a-z1','Mutual fund industry AUM reached ₹79.46 lakh crore in March 2026, having been ₹12.33 lakh crore in March 2016. The CAGR is about:','["30%","8%","20.48%","12%"]',2,'As per the workbook growth data.',30) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q31','nism-5a-z1','Balanced Hybrid funds hold equity of:','["40–60%, debt 40–60%, with no arbitrage","10–25%","≥65%","65–80%"]',0,'Balanced hybrid: equity 40–60%, debt 40–60%.',31) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q32','nism-5a-z1','An ELSS must invest at least ___ in equity.','["90%","75%","65%","80%"]',3,'ELSS: ≥80% equity with 3-year lock-in.',32) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q33','nism-5a-z1','An Equity Savings fund holds at least ___ equity and ___ debt, with net equity of 15–40%.','["50%; 20%","65%; 10%","75%; 15%","80%; 5%"]',1,'Equity savings: ≥65% equity, ≥10% debt, net equity 15–40%.',33) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q34','nism-5a-z1','For an interval fund, the minimum transaction period and interval period are respectively:','["3 days and 60 days","2 days and 15 calendar days","1 day and 7 days","5 days and 30 days"]',1,'Transaction period at least 2 days; interval period at least 15 calendar days.',34) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q35','nism-5a-z1','A Credit Risk fund must invest at least ___ in corporate bonds rated AA and below (excluding AA+).','["80%","75%","65%","50%"]',2,'Credit risk ≥65% in AA and below.',35) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q36','nism-5a-z1','"Mark to Market" in a mutual fund means:','["Valuation at cost price","Valuation once a year","Daily valuation of each security at current market value","Valuation at face value"]',2,'MTM ensures NAV reflects true worth.',36) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q37','nism-5a-z1','The maximum unhedged short exposure in a SIF strategy is:','["50% of NAV","25% of NAV","10% of NAV","100% of NAV"]',1,'Only one strategy per category may be offered.',37) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q38','nism-5a-z1','Index funds and ETFs must invest at least ___ in the index securities.','["75%","65%","80%","95%"]',3,'Index funds/ETFs ≥95%; Fund of Funds ≥95% in the underlying fund.',38) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q39','nism-5a-z1','REITs and InvITs are:','["Mutual fund schemes","Registered with SEBI but not mutual fund schemes","Regulated by RBI","Bank deposits"]',1,'They are listed trust structures, not mutual funds.',39) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q40','nism-5a-z1','Assets Under Management (AUM) of a scheme equals:','["Face value × investors","Number of folios × NAV","NAV × units outstanding","Unit capital − expenses"]',2,'AUM = NAV × units outstanding.',40) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q41','nism-5a-z1','The minimum investment per investor in Specialized Investment Funds (SIF) across an AMC''s SIF strategies is:','["₹50 lakh","₹1 lakh","₹5 lakh","₹10 lakh"]',3,'SIF bridges the gap between MFs and PMS.',41) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q42','nism-5a-z1','Which statement about ETFs is correct?','["They can only be bought in the NFO","They have a single end-of-day price only","They trade on a stock exchange throughout the day and need a demat account","They are always actively managed"]',2,'ETFs have multiple intra-day prices vs a single NAV for open-ended funds.',42) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q43','nism-5a-z1','The Macaulay duration of an Ultra-Short Term fund portfolio is:','["3 to 6 months","6 to 12 months","1 to 3 years","Above 7 years"]',0,'Ultra short: 3–6 months; Low duration: 6–12 months.',43) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q44','nism-5a-z1','An Overnight fund invests in securities with a maturity of:','["1 year","1 day","7 days","91 days"]',1,'Overnight = 1-day maturity securities.',44) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q45','nism-5a-z1','The statutory lock-in of an ELSS is:','["5 years","1 year","10 years","3 years from each investment"]',3,'Each SIP instalment is locked for 3 years separately.',45) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q46','nism-5a-z1','In a Life Cycle Fund, as maturity approaches:','["Equity increases and debt reduces","Equity reduces and debt increases","Gold is increased to 100%","Both stay constant"]',1,'This is the glide path.',46) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q47','nism-5a-z1','Overnight funds may keep at most ___ in G-secs/T-bills of up to 30 days as margin.','["5%","20%","10%","15%"]',0,'Overnight funds may place ≤5% as margin.',47) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q48','nism-5a-z1','A Large & Mid Cap fund must invest at least:','["80% in large caps","35% in large caps and 35% in mid caps","65% in mid caps","25% each in large and mid caps"]',1,'Large & Mid Cap: ≥35% large + ≥35% mid.',48) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q49','nism-5a-z1','ELSS investors can claim deduction under Section 80C up to:','["₹50,000 under any regime","₹2,50,000 under the New Tax Regime","₹5,00,000 under the Old Tax Regime","₹1,50,000 under the Old Tax Regime"]',3,'Deduction up to ₹1.5 lakh, Old Tax Regime only.',49) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q50','nism-5a-z1','A Focused fund can hold a maximum of:','["100 stocks","20 stocks","50 stocks","30 stocks"]',3,'Focused: max 30 stocks, ≥80% in equity.',50) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q51','nism-5a-z1','Which of the following is NOT an advantage of mutual funds?','["Transparency","Professional management","Affordable diversification","Guaranteed returns"]',3,'Mutual funds are pass-through vehicles; returns are never guaranteed.',51) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q52','nism-5a-z1','A close-ended scheme can be bought by investors:','["Only during the NFO","Only during transaction periods","At any time at NAV","Only on Sundays"]',0,'Close-ended units are bought in the NFO and then traded on exchange.',52) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m3','nism-5a','Ch 3: Legal Structure of Mutual Funds in India',4,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-AA8Y_k69Wh0','nism-5a','nism-5a-m3','Video lesson: Chapter 3: Legal Structure of Mutual Funds','video','AA8Y_k69Wh0','',32,'N V Finance',1,14) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l15','nism-5a','nism-5a-m3','Summary notes 1/3: Definition, Structure and Who Does What to Asset Management Company','note','## Definition, Structure and Who Does What

- **Mutual Fund:** Definition & Structure

- SEBI (MF) Regulations 2026: a fund set up as a trust, registered under Reg. 3, raising money by sale of units under one or more schemes
- Invests in securities, money market, gold/silver & related instruments, real estate & other SEBI-specified assets
- Must set up a separate AMC to run the business
- **Three-tier structure:** Sponsor → Trust (Trustees) → AMC
- Governed by Indian Trusts Act, 1882; beneficiaries = unitholders
- Trust Deed executed between sponsor and trustees (SEBI-specified clauses); registered under Indian Registration Act, 1908

- **Who Does What**

| Constituent | Role / appointed by |
| --- | --- |
| Sponsor | Creates the trust; applies to SEBI; invests in AMC capital |
| Trustees | Protect unitholders; individuals (Board of Trustees) or trustee company |
| AMC | Day-to-day management; appointed by sponsor/trustees via investment management agreement |
| Custodian | Holds scheme assets; appointed by trustees |
| RTA | Maintains investor records; appointed by AMC (optional) |

## Sponsor Eligibility

- Sound track record, reputation of fairness & integrity; fit and proper
- In financial services business for ≥ 5 years
- Positive net worth in each of the preceding 5 years
- Positive liquid net worth > proposed capital contribution to AMC
  - **On change in control:** liquid net worth ≥ higher of par/market value of shares acquired
- Net profit (after depreciation, interest & tax) in each of preceding 5 years
- Average annual net profit ≥ ₹10 crore over preceding 5 years
- **AMFI lists AMCs by sponsor category:** banks, institutions, private (Indian, foreign, JVs)

## Trustees

- **Eligibility (Reg. 11):** fit & proper; not a director/officer/employee of an AMC; not trustee of another MF; provide SEBI info
- Prior SEBI approval needed
- At least 2/3 of trustee board must be independent (not associates of sponsor/AMC/trustee co.)
- Rights & responsibilities:
  - Appoint and terminate AMC
  - Address conflicts of interest & broker empanelment
  - Regulatory compliance; oversight for investor interests
  - Due diligence on matters specified by SEBI

## Asset Management Company

- Appointed by sponsor/trustees with SEBI approval
- **Directors:** experienced in finance; fit & proper; ≥50% not associates of sponsor or trustees
- AMC directors cannot sit on any trustee board; cannot be director of more than one AMC
- Net worth ≥ ₹50 crore (from 1 Jan 2024), maintained continuously – sponsor''s duty
- **Change in control:** trustees + SEBI approval; notify unitholders + ads; exit at NAV without load ≥ 30 calendar days
- Runs offices, staff, software, marketing; due diligence in investments
- Can be terminated by majority of trustees or 75% of unitholders (SEBI + unitholder approval)',12,1,15) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l16','nism-5a','nism-5a-m3','Summary notes 2/3: Custodian to Service Providers (2/2)','note','## Custodian

- Holds the fund''s assets; settles purchase & sale transactions
- Registered with SEBI (Custodian Regulations 1996); appointed by trustees under custodial agreement
- **Independence:** if sponsor/associates hold ≥50% voting rights or ≥50% directors – cannot act (unless conditions met)
- **Tracks corporate actions:** dividends, bonus, rights

## Organisation Structure of an AMC

- **Compliance:** signs due-diligence certificate for scheme documents; reports to AMC head; reports non-compliance to trustees
- Fund management (core function):
  - Analysts – identify opportunities (equity, credit, interest rates)
  - Fund managers – decide investments; responsible for performance
  - Dealers – place orders with brokers
- **Operations & customer service:** front office, back office, call centres, chatbots; RTA; custody team; fund accounting (daily NAV)
- **Risk Management Framework:** independent risk function – officers for investment, compliance, operational & cyber risk
- **Sales & marketing:** branding, ads, events, distributor relationships & training
- **Support:** Accounts (AMC finances), Administration, HRD, IT

## Service Providers (1/2)

- **Fund accountant:** calculates NAV; in-house or outsourced; no SEBI registration needed
- **RTA:** investor records (folios), purchase/redemption processing, unit capital updates; ISCs; appointed by AMC; SEBI-registered; optional
- **Auditors:** scheme auditor (appointed by trustees) must differ from AMC auditor (appointed by AMC)
- **Distributors:** individuals or institutions; pass NISM V-A + AMFI registration (ARN); can work with many AMCs
  - **New cadre:** NISM V-B Foundation – sell limited set of schemes
- Collecting bankers (appointed by AMC) & payment aggregators (gateways, wallets, payment banks)

## Service Providers (2/2)

- **KYC Registration Agencies (KRAs):** common KYC under PMLA; SEBI-registered (2011 regulations); share data; maintain confidentiality
- **Valuation agencies:** CRISIL & ICRA appointed by AMFI for non-traded/thinly traded debt
- **Credit rating agencies:** initial input for debt investing; define corporate bond & credit risk funds; FMPs disclose proposed rating profile
- **Depositories:** NSDL & CDSL, via Depository Participants; ETF units compulsorily demat
- **Stock exchange platforms:** BSE StAR MF, NSE NMF-II; MF Utilities (AMFI initiative)
- **MF Central:** investor hub by KFintech & CAMS',12,1,16) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l17','nism-5a','nism-5a-m3','Summary notes 3/3: Execution Only Platforms (EOP) to Role of AMFI','note','## Execution Only Platforms (EOP)

- Digital platforms for subscription, redemption & switch in direct plans
- **Not covered:** platforms of SEBI RIAs and stock brokers for their own clients

| Category 1 EOP | Category 2 EOP |
| --- | --- |
| Registered with AMFI | Registered as stock broker (EOP segment of exchanges) |
| Body corporate; agent of AMCs | Body corporate; agent of investor |
| Integrates with AMCs/RTAs; may aggregate | Operates only via exchange platforms |

## Role of AMFI

- Association of all SEBI-registered AMCs
- Maintain professional & ethical standards; promote best practices & code of conduct
- Represent industry to SEBI, Government, RBI
- Nationwide investor awareness; data, studies & research
- Register distributors – allot ARN (mandatory); regulate conduct incl. ARN cancellation
- Protect investor interests; issue best-practice circulars
- AMFI is neither a regulator nor an SRO',6,1,17) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z2','nism-5a','nism-5a-m3','Chapter 3 practice',24,50,0,0,0,1,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q0','nism-5a-z2','The minimum net worth of an AMC (from 1 January 2024) is:','["₹25 crore","₹10 crore","₹50 crore","₹100 crore"]',2,'Maintained continuously; the sponsor''s duty.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q1','nism-5a-z2','A custodian cannot act for the fund if the sponsor or its associates hold ___ or more of the voting rights.','["10%","25%","50%","75%"]',2,'Unless specified conditions are met.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q2','nism-5a-z2','The fund accountant calculates:','["Distributor commission","Tax on IDCW","NAV","KYC status"]',2,'No SEBI registration is required for the fund accountant.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q3','nism-5a-z2','At least what proportion of the board of trustees must be independent?','["One-half","Three-fourths","Two-thirds","One-third"]',2,'Independent = not associates of sponsor/AMC/trustee company.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q4','nism-5a-z2','The custodian is appointed by:','["AMFI","The AMC","The sponsor","The trustees"]',3,'Custodians are registered with SEBI under the Custodian Regulations, 1996.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q5','nism-5a-z2','A sponsor must have been in the financial services business for at least:','["5 years","1 year","3 years","10 years"]',0,'Also positive net worth and net profit in each of the preceding 5 years.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q6','nism-5a-z2','The average annual net profit of a sponsor over the preceding 5 years must be at least:','["₹50 crore","₹5 crore","₹1 crore","₹10 crore"]',3,'This is part of sponsor eligibility.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q7','nism-5a-z2','On a change in control of an AMC, unitholders must be given an exit option at NAV without load for at least:','["15 days","7 days","30 calendar days","90 days"]',2,'Also notice to unitholders and advertisement.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q8','nism-5a-z2','Execution Only Platforms (EOP) facilitate transactions in:','["Insurance products","Close-ended schemes only","Regular plans only","Direct plans"]',3,'Platforms of RIAs and stockbrokers for their own clients are not covered.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q9','nism-5a-z2','The scheme auditor is appointed by:','["AMFI","The trustees","The AMC","SEBI"]',1,'The scheme auditor must differ from the AMC auditor (appointed by the AMC).',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q10','nism-5a-z2','Which of the following is a stock exchange platform for mutual fund transactions?','["CAN","BSE StAR MF","SCORES","MF Central"]',1,'Also NSE NMF-II.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q11','nism-5a-z2','MF Central is an investor hub created by:','["CRISIL and ICRA","NSDL and CDSL","CAMS and KFintech","BSE and NSE"]',2,'It went live on 31 December 2021.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q12','nism-5a-z2','AMFI is:','["Neither a regulator nor a self-regulatory organisation","A stock exchange","A regulator","A government ministry"]',0,'AMFI is an association of AMCs and issues ARN.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q13','nism-5a-z2','Beneficiaries of the mutual fund trust are:','["The AMC","The trustees","The sponsor","Unitholders"]',3,'Trustees hold the assets for unitholders.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q14','nism-5a-z2','The AMC can be terminated by:','["AMFI alone","The distributor","A majority of trustees or 75% of unitholders","The custodian"]',2,'SEBI and unitholder approval are needed.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q15','nism-5a-z2','The Registrar and Transfer Agent (RTA) is appointed by:','["The AMC","The trustees","The custodian","SEBI"]',0,'The RTA is optional; the AMC can do it in-house.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q16','nism-5a-z2','Valuation agencies appointed by AMFI for non-traded/thinly traded debt are:','["CIBIL and Equifax","CAMS and KFintech","NSDL and CDSL","CRISIL and ICRA"]',3,'They provide valuation inputs.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q17','nism-5a-z2','At least ___ of the AMC directors must not be associates of the sponsor or trustees.','["50%","75%","25%","100%"]',0,'AMC directors cannot sit on any trustee board.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q18','nism-5a-z2','The three-tier structure of a mutual fund is:','["SEBI → Sponsor → Distributor","RTA → AMC → Trustees","Sponsor → Trust (Trustees) → AMC","Sponsor → AMC → Custodian"]',2,'Sponsor creates the trust; trustees oversee; AMC manages.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q19','nism-5a-z2','The ARN (AMFI Registration Number) is allotted by:','["RBI","SEBI","NISM","AMFI"]',3,'ARN is mandatory for distributors.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m4','nism-5a','Ch 4: Legal and Regulatory Framework',10,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-QBiKF20D4h4','nism-5a','nism-5a-m4','Video lesson: Chapter 4: Legal & Regulatory Framework','video','QBiKF20D4h4','',40,'N V Finance',1,18) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l19','nism-5a','nism-5a-m4','Summary notes 1/4: Regulators in India and the Role of SEBI to Investment Universe – Regulation 39','note','## Regulators in India and the Role of SEBI

- **Regulators in India**

- **Purpose:** protect consumers of financial products + orderly market development

| Regulator | Regulates |
| --- | --- |
| RBI | Banking system and money markets (also forex) |
| SEBI | Securities markets – MFs, depositories, custodians, RTAs, CRAs |
| IRDAI | Insurance |
| PFRDA | Pension |

- All come under the Ministry of Finance
- ''Securities'' defined in Sec 2(h) of Securities Contracts (Regulation) Act, 1956

- **Role of SEBI**

- **Preamble:** protect investors'' interests, promote development of, and regulate the securities market
- **Three focus areas:** issuer disclosures, efficient transactions, low transaction costs
- **Also curbs:** speculation, insider trading, excessive MF risk, inadequate collateral
- MF Regulations first issued 1996 → replaced by SEBI (MF) Regulations 2026
- Master Circulars on www.sebi.gov.in consolidate circulars
- MFs also follow RBI rules (money market, overseas investment, forex) and stock exchange rules

## SEBI Regulation Categories (1/2)

- **Scheme related documents:** content, frequency; benchmark against Total Return Index (TRI) not Price Return Index
- Registration of AMC, sponsor, trustees; AMC mergers & management change
- **Conversion & consolidation:** one scheme per category; merger procedure
  - Potential Risk Class (PRC) matrix for debt schemes – max interest rate risk (Macaulay duration) × max credit risk (CRV)
- New products (e.g. IDFs, ESG)
- **Risk management:** operational risk, exposure limits, segregated portfolios (after 2018 credit crisis)
  - **2008 reforms:** no premature FMP redemption; "liquid plus" names banned
- Disclosures & reporting norms; governance norms (audit & valuation committees, minimum investors, systems audit)

## SEBI Regulation Categories (2/2)

- Secondary market activities; NAV (rounding, cut-off, time stamping); Valuation
- Loads, fees & expenses incl. commission disclosure
- IDCW distribution procedure (distributable surplus)
- Investment by schemes – restrictions & limits
- Advertisements – content, disclaimers, frequency
- Investor rights & obligations – statements, payout delays & penalty, instant access in liquid funds
- Certification & registration of intermediaries incl. CPE
- Transactions in MF units – exchanges, records, KYC
- Corporate Debt Market Development Fund (CDMDF); Execution Only Platforms; MF Lite; SIF; Miscellaneous

## Investment Universe – Regulation 39

- AMC may invest scheme funds only in:
  - Securities
  - Money market instruments
  - Privately placed debentures
  - Securitised debt (asset-backed / mortgage-backed)
  - Gold or gold-related instruments
  - Silver or silver-related instruments
  - Any other asset specified by SEBI
- MF is a pass-through vehicle – restrictions control fund manager risks; apply at time of investment',12,1,19) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l20','nism-5a','nism-5a-m4','Summary notes 2/4: Investment Restrictions – Regulation 41 to Performance Advertising Rules','note','## Investment Restrictions – Regulation 41

- All investments (except gold/silver ETFs) subject to Sixth Schedule limits
- **Gold/silver ETFs:** invest only in gold/silver instruments (plus liquidity); may use exchange-traded commodity derivatives; pending deployment → short-term bank deposits
- Settle transactions only in demat securities (except specified)
- No carry-forward transactions (except as specified)
- Derivatives only on recognised exchanges
- Short selling only on exchange under SLB framework
- Inter-scheme transfers as per SEBI conditions

## Investment Restrictions – Sixth Schedule

- Equity & debt only in listed/to-be-listed securities – except unlisted G-secs, money market (not CPs), unlisted NCDs as specified
- Unrated debt – subject to SEBI conditions
- Inter-scheme investment allowed without fees, within limits (not for FoFs)
- No scheme may invest in a Fund of Funds; FoF cannot invest in another FoF
- FoF invests only in MF schemes (except liquidity needs)
- All purchases/sales on delivery basis (exceptions: short selling, derivatives, G-sec as per RBI)
- Securities held in the name of the mutual fund for the scheme
- Pending deployment → short-term deposits of scheduled commercial banks

## SEBI Advertisement Code (Fifth Schedule)

- Accurate, true, fair, clear, complete, unambiguous, concise – not misleading
- No projections, testimonials or rankings; no exaggerated slogans
- No celebrities in scheme/AMC ads
- Avoid jargon and excessive detail; consistent with SID, SAI, KIM
- No discrediting others or unfair comparisons
- **Standard warning:** "Mutual Fund investments are subject to market risks, read all scheme related documents carefully." – no changes
  - Vernacular ads → warning in same language
  - **Audio-visual:** visual + voice-over, 14 words for ≥ 5 seconds
- **IDCW ads:** show ₹ per unit, face value, prevailing NAV; NAV falls to extent of payout + levy
- **Close-ended/interval maturity:** "entire distributable surplus … shall be distributed"

## Performance Advertising Rules

- **Scheme > 3 years:** CAGR for 1, 3, 5 years & since inception (date of allotment) + point-to-point value of ₹10,000
- Data up to last day of preceding month; state regular or direct plan; note fund manager changes
- **Scheme < 6 months:** no performance; 6–12 months: simple annualised 6-month return
- **Overnight, liquid, money market:** simple annualised yields for 7, 15, 30 days
- Also show performance of all other schemes of the same fund manager (1, 3, 5 yr CAGR)
  - > 6 schemes → total count + top 3 and bottom 3
  - Internet ads may link to the summary',12,1,20) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l21','nism-5a','nism-5a-m4','Summary notes 3/4: Standard Additional Benchmarks to Investors'' Rights (2/2)','note','## Standard Additional Benchmarks

| Scheme type | Additional benchmark |
| --- | --- |
| Equity | Sensex / Nifty |
| Debt ≤ 1 yr duration & Arbitrage | 1-year T-Bill |
| Other debt schemes | 10-year GoI security |
| Conservative Hybrid | 10-year GoI security |
| Balanced/Aggressive Hybrid, BAF, Multi Asset | Sensex or Nifty |
| Equity Savings | 10-year GoI security |
| Index Funds/ETFs & FoFs | Based on underlying allocation |
| Retirement / Children''s Fund | Sensex / Nifty |

- Part of SAI and all advertisements

## Celebrity Endorsement & Unauthenticated News

- Celebrities allowed only at industry level – for MF awareness
  - Not for any scheme or AMC branding
  - Paid from industry-pooled investor education funds
  - Prior SEBI approval required
- Unauthenticated news – intermediaries must:
  - Have internal code; staff must not circulate rumours
  - Restrict/supervise access to blogs, chat, messenger
  - Keep logs as records
  - Forward market news only after Compliance Officer approval – else both liable

## Investors'' Rights (1/2)

- **Beneficial ownership:** proportionate right in scheme assets; unit certificate or demat; demat units freely transferable (ELSS restricted during lock-in)
- **Change distributor or go direct:** written request; no NOC needed
- **Inspect documents:** Trust Deed, IMA, custodial & RTA agreements, AMC MoA/AoA
- **Nominees:** up to 3; specify % split (else equal)
- Pledge units as security to a financier
- **Grievance redressal:** complaint status in annual report, AMC & AMFI website; pending complaints may block new schemes

## Investors'' Rights (2/2)

- **Change in fundamental attributes:** written/digital notice + website disclosure + exit at NAV without load for ≥ 30 days
- 75% unitholders can terminate AMC or wind up a scheme
- Trustees must obtain unitholder consent when SEBI or 75% unitholders require, or on winding up/premature redemption
- Can sue trustees (not the trust) for breach of trust
- **Unclaimed amounts:** claimed within 3 yrs → prevailing NAV; after 3 yrs → NAV at end of 3 yrs
  - Deployed in separate liquid fund plan; max fee 0.50% p.a.; no exit load
- Daily disclosure of debt/money market trades with 15-day lag
- **Illiquid security recovered:** substantial & within 2 yrs → old investors; else Investor Education Fund',12,1,21) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l22','nism-5a','nism-5a-m4','Summary notes 4/4: Grievance Redress and Cyber Security to AMFI Codes','note','## Grievance Redress and Cyber Security

- **Grievance Redress & Due Diligence**

- AMCs conduct due diligence on distributors (AMFI may coordinate unified process) – see Ch 6
- **Investor path:** Investor Service Centre → senior AMC levels → SEBI
- AMC must redress within 21 calendar days
- **SCORES:** SEBI''s online system to lodge & track complaints (physical complaints scanned in)
  - Covers listed cos/RTAs, brokers/exchanges, DPs/depositories, MFs, PMS, KRAs, CRAs etc.
- **SMART ODR:** online conciliation & arbitration if unsatisfied with AMC/SCORES
- Caveat emptor applies; prospective investors don''t have unitholder rights

- **Cyber Security & Cyber Resilience**

- SEBI CSCRF for all Regulated Entities – standards based, standard reporting formats
- **Five goals (from CERT-In CCMP):** Anticipate, Withstand, Contain, Recover, Evolve
- Address AI-enabled threats; task force cybersuraksha.ai
- **Report cyber incidents:** mkt_incidents@sebi.gov.in within 6 hours; SEBI Incident Reporting Portal within 24 hours
- Portal aligned with FSB''s FIRE (Format for Incident Reporting Exchange)

## AMFI Codes

- **SEBI Fourth Schedule:** Code of Conduct for AMCs & Trustees (broad principles)
- **AMFI Code of Ethics (ACE):** more explicit, higher standards for AMCs & Trustees
- AGNI – AMFI Guidelines & Norms for Intermediaries: agents, brokers, distribution houses, banks
- Breach procedure:
  - AMFI seeks explanation within 3 weeks
  - No/unsatisfactory reply → warning letter
  - Proven second violation → ARN cancelled; all AMCs informed
  - Intermediary may appeal to AMFI',6,1,22) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z3','nism-5a','nism-5a-m4','Chapter 4 practice',30,50,0,0,0,1,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q0','nism-5a-z3','No scheme of a mutual fund may invest in a:','["Government security","Fund of Funds","Index fund","Liquid scheme"]',1,'A FoF cannot invest in another FoF either.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q1','nism-5a-z3','The additional benchmark for a Conservative Hybrid scheme is:','["10-year GoI security","Sensex/Nifty","Gold","1-year T-bill"]',0,'Balanced/aggressive hybrid use Sensex or Nifty.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q2','nism-5a-z3','Which regulator regulates the securities markets, including mutual funds?','["SEBI","RBI","PFRDA","IRDAI"]',0,'RBI – banking; IRDAI – insurance; PFRDA – pension.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q3','nism-5a-z3','Pending deployment, funds may be kept in short-term deposits of:','["Scheduled commercial banks","NBFCs","Any bank","Co-operative banks"]',0,'Per the Sixth Schedule.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q4','nism-5a-z3','The AMFI guidelines applicable to intermediaries are called:','["CAMS","ACE","SCORES","AGNI"]',3,'ACE = AMFI Code of Ethics for AMCs and trustees.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q5','nism-5a-z3','A mutual fund scheme can undertake short selling:','["Without restriction","Only on exchange under the SLB framework","Only in OTC markets","Only through the AMC"]',1,'Derivatives only on recognised exchanges.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q6','nism-5a-z3','The AMC must redress an investor complaint within:','["6 months","21 calendar days","60 days","7 days"]',1,'Then the investor may approach SEBI SCORES.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q7','nism-5a-z3','Cyber incidents must be reported by email to SEBI within ___ and on the Incident Reporting Portal within ___.','["1 hour; 6 hours","6 hours; 24 hours","24 hours; 48 hours","48 hours; 7 days"]',1,'As per the SEBI CSCRF.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q8','nism-5a-z3','Celebrities in mutual fund advertising are allowed:','["For AMC branding","Without any approval","For any scheme branding","Only at the industry level for MF awareness, with prior SEBI approval"]',3,'Paid from industry-pooled investor education funds.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q9','nism-5a-z3','For a scheme with performance history of more than 3 years, advertisements must show CAGR for:','["Only the last month","1, 3, 5 years and since inception","10 years only","1 and 2 years only"]',1,'Plus the point-to-point value of ₹10,000.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q10','nism-5a-z3','SEBI mutual fund regulations were first issued in 1996 and replaced by:','["SEBI (MF) Regulations, 2020","SEBI (MF) Regulations, 2018","SEBI (Mutual Funds) Regulations, 2026","Companies Act, 2013"]',2,'Per the Sept 2026 workbook.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q11','nism-5a-z3','The Potential Risk Class (PRC) matrix applies to:','["Hybrid schemes only","Equity schemes","ETFs only","Debt schemes"]',3,'Maximum interest rate risk × maximum credit risk.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q12','nism-5a-z3','SEBI''s online system for lodging and tracking investor complaints is:','["ARN","MFU","CAN","SCORES"]',3,'SMART ODR provides online conciliation and arbitration.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q13','nism-5a-z3','For a breach of the AMFI code, AMFI first seeks an explanation from the intermediary within:','["3 weeks","3 months","1 year","3 days"]',0,'A proven second violation leads to ARN cancellation.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q14','nism-5a-z3','On a change in fundamental attributes, unitholders must be given an exit option at NAV without load for at least:','["60 days","30 days","15 days","7 days"]',1,'Plus notice and website disclosure.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q15','nism-5a-z3','Unitholders holding what percentage can terminate the AMC or wind up a scheme?','["66%","90%","75%","51%"]',2,'By resolution of unitholders.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q16','nism-5a-z3','For a scheme older than 6 months but under 12 months, the ad may show:','["CAGR for 5 years","Simple annualised 6-month return","No return at all","Projected returns"]',1,'Schemes <6 months: no performance.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q17','nism-5a-z3','Unclaimed redemption/IDCW amounts, if claimed within 3 years, are paid at:','["NAV at the end of 3 years","Cost price","Face value","Prevailing NAV"]',3,'After 3 years: NAV at the end of 3 years.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q18','nism-5a-z3','An investor can nominate up to ___ nominees in a folio.','["3","1","2","5"]',0,'The percentage split must be specified; otherwise equal.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q19','nism-5a-z3','Unclaimed amounts are deployed in a separate liquid fund plan with a maximum fee of:','["0.10% p.a.","1.00% p.a.","0.50% p.a.","2.00% p.a."]',2,'No exit load.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q20','nism-5a-z3','The standard additional benchmark for equity schemes is:','["Gold price","Sensex or Nifty","10-year GoI security","1-year T-bill"]',1,'Debt ≤1 year and Arbitrage: 1-year T-bill; others: 10-year GoI.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q21','nism-5a-z3','Mutual fund scheme funds may be invested in all EXCEPT:','["Securities","Real estate bought directly by the scheme","Gold","Money market instruments"]',1,'Regulation 39 lists permitted universe including gold and silver instruments.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q22','nism-5a-z3','Scheme performance must be benchmarked against a:','["Gold price","Price Return Index","Bank FD rate","Total Return Index (TRI)"]',3,'TRI includes dividends.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q23','nism-5a-z3','The standard warning in a mutual fund advertisement is:','["\"Returns are guaranteed.\"","\"SEBI recommends this scheme.\"","\"Past performance is always repeated.\"","\"Mutual Fund investments are subject to market risks, read all scheme related documents carefully.\""]',3,'It must be used without changes; in vernacular ads, in the same language.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q24','nism-5a-z3','An investor can change distributor or go direct by:','["Obtaining an NOC from the old distributor","Paying a fee to AMFI","Waiting 3 years","A written request, without NOC from the existing distributor"]',3,'No NOC is required.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m5','nism-5a','Ch 5: Scheme Related Information',10,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-Y5qUlpr4HZo','nism-5a','nism-5a-m5','Video lesson: Chapter 5: Scheme Related Information','video','Y5qUlpr4HZo','',44,'N V Finance',1,23) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l24','nism-5a','nism-5a-m5','Summary notes 1/3: Scheme Related Documents to Fundamental Attributes','note','## Scheme Related Documents

- **Mandatory:** Scheme Information Document (SID), Statement of Additional Information (SAI), Key Information Memorandum (KIM)
- Caveat emptor – investor presumed to have read them; signing the form = accepting the offer (contract)
- **SID:** scheme-specific details · SAI: statutory info on the MF/AMC – one SAI for all schemes (legally part of SID)
- SEBI-prescribed format & sequence; simple language; MF may add material disclosures
- SEBI does not approve – it "vets" (gives observations)
- Drafts on SEBI website; final documents on AMFI website and AMC website

## SID – Cover Page & Structure

- **Cover page:** scheme name, type (open/close/interval; equity/debt…), face value, NFO dates, SID date, MF, AMC & trustee details
- **Standard clause:** filed with SEBI with AMC''s Due Diligence Certificate; not approved/recommended by SEBI
- Risk-o-meter and suitability statement on front page
- **Sections:** Highlights · Introduction · Risk factors (standard & scheme-specific) · Minimum investors · Definitions · Due Diligence Certificate
- **Information about the scheme:** objective, asset allocation, where it invests, strategy, fundamental attributes, benchmark, fund managers, restrictions, performance
- Units & Offer · Fees & Expenses · Rights of Unitholders · Penalties & Litigation
- Valid until a material change → filed with SEBI and communicated

## Using the SID to Decide

- Eligible / ineligible investors – NFO & ongoing offer section
- **Suitability:** risk factors, type, objective, asset allocation, instruments, strategy
  - **Standard risks:** volatility, no guarantee, sponsor liability limited, past performance not indicative
  - **Specific risks:** credit, interest rate, liquidity, prepayment, reinvestment, equity volatility, derivatives, foreign
- **When to buy:** open-ended (NFO + ongoing), close-ended (NFO only), interval (NFO + transaction periods)
- **How to apply:** read SID with SAI – PAN, KYC, bank details, cut-off, minors, NRIs, demat
- Prices, loads, min/max investment, plans (Regular/Direct) & options (IDCW payout, reinvestment, sweep, growth)
- Modes of transaction, liquidity & redemption, fees & expenses, special facilities (SIP, STP, switch), NAV computation, tax

## Fundamental Attributes

- **Type of scheme:** open/close-ended/interval; sectoral, equity, balanced, income, index etc.
- **Investment objective:** growth / income / both; min–max asset allocation (defensive deviation allowed short term)
- **Terms of issue:** liquidity (listing, repurchase, redemption); aggregate fees & expenses; any safety net/guarantee
- Change allowed only if (Reg 22(9)(c)):
  - Written/digital communication to each unitholder
  - Details on AMC website
  - Exit option at prevailing NAV without exit load',12,1,24) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l25','nism-5a','nism-5a-m5','Summary notes 2/3: Statement of Additional Information (SAI) to Ongoing Disclosures: NAV','note','## Statement of Additional Information (SAI)

| Section | Covers |
| --- | --- |
| Constituents | Sponsor, AMC, Trustee, Custodian, RTA, Auditor, Fund accountant, Bankers – experience, financials, key people |
| How to apply | Application guidance |
| Rights of unitholders | Ownership, service timelines, information, exit on changes |
| Valuation norms | SEBI-standardised valuation rules |
| Tax, legal & general | Nomination, transfer, transmission, minors, pledge/lien, taxation |
| Investor grievance | How to register a grievance |

- On AMC & AMFI websites; investor may ask for printed copy

## Key Information Memorandum (KIM)

- Summary of SID & SAI – must accompany every application form
- Contents:
  - Names of AMC, MF, trustee, fund manager, scheme
  - NFO opening, closing & re-opening dates
  - Investment objective & asset allocation
  - Risk profile – risk to principal, horizon, securities
  - Plans & options, benchmark, dividend policy
  - **Performance vs benchmark:** 1, 3, 5 yrs & since inception
  - Expenses; grievance registration
- **Addendum:** interim changes; part of scheme documents; must accompany KIM

## Updating Scheme Documents

| Document | Update rule |
| --- | --- |
| SID (open-ended/interval) | First within 6 months of half-year end after launch; then within 1 month of each half-year (Sept/Mar data) |
| SAI | Within 3 months of every financial year end; material changes ongoing |
| KIM | At least once every half-year, within 1 month (Sept/Mar data); filed electronically with SEBI |

- **Change in fundamental attributes:** addendum on website immediately; SID revised after exit window (≥30 days); public notice in English national daily + regional-language paper
- **Other changes:** addendum on website; circulate to distributors/ISCs; attach to KIM & SID in stock; account statements show load structure

## Ongoing Disclosures: NAV

- Current value = Unit balance × current NAV
- NAV disclosed every business day on AMC website and AMFI website
- **Liquid & overnight funds:** NAV declared on Sundays/holidays too (daily accrual)
- **Close-ended schemes:** NAV at least once a week
- Separate time limit for schemes investing overseas
- Historical NAVs let investors compute performance for any period',12,1,25) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l26','nism-5a','nism-5a-m5','Summary notes 3/3: Total Expense Ratio Disclosures to Non-Mandatory: Fund Factsheet','note','## Total Expense Ratio Disclosures

- Daily scheme-wise TER on AMC & AMFI websites (except IDFs) – downloadable, machine-readable
- TER = Base Expense Ratio (BER) + Brokerage + Transaction cost + Statutory levies (incl. GST)
- **BER change:** email/SMS + website notice ≥ 3 working days before
  - **Exempt:** change due only to AUM movement or regulatory decrease
  - Report to AMC Board (with rationale) and Trustees quarterly
- **SID/KIM:** weblink to last 6 months'' TER, daily TER & factsheet; illustration of TER impact for Direct & Regular
- **Half-yearly CAS:** average TER with split – advisory fees, distributor commission, other expenses
- **Annual accounts:** any item > 10% of total expenses shown separately; abridged report shows TER as % of AAUM plan-wise

## Dashboard & Risk-o-meter

- Scheme performance dashboard on AMC website (also AMFI): name, category, type, objective, fund manager, benchmark, exit load/lock-in, plans/options, min investment, AUM, TER, inception, portfolio, performance

| Risk level | Colour |
| --- | --- |
| Low | Irish Green |
| Low to Moderate | Chartreuse |
| Moderate | Neon Yellow |
| Moderately High | Caramel |
| High | Dark Orange |
| Very High | Red |

- Evaluated monthly; change → notice-cum-addendum + email/SMS; show scheme & benchmark risk-o-meter with performance
- Commodity risk by annualised volatility (15-yr prices, quarterly): <10% → 3, 10–15% → 4, 15–20% → 5, >20% → 6
- First step only – not the sole basis for decision

## Portfolio, Results & Annual Reports

- Portfolio (with ISIN) as of month-end / half-year: on AMC & AMFI websites within 10 days; spreadsheet format; yield shown
- **Debt schemes:** fortnightly portfolio within 5 days
- Emailed to registered unitholders within 10 days
- Unaudited half-yearly results (31 Mar & 30 Sep) on website within 1 month; unitholders informed
- **Annual report/abridged summary:** on AMC & AMFI sites; emailed within 4 months of 31 March; physical copy on request
  - Ads in two all-India dailies (English & Hindi); functional link on website
- **Change in control:** draft letter/email and draft ad filed with SEBI

## Non-Mandatory: Fund Factsheet

- Monthly, voluntary – AMFI best practice; SEBI disclosure rules still apply
- **Contents:** inception date, AUM, NAV, benchmark, style box, performance vs benchmark, SIP returns
- **Equity:** sector & security allocation (some show top 10), derivative exposure (hedging only)
- **Debt:** rating profile, average maturity, duration
- **Ratios:** P/E, standard deviation, beta, Sharpe, information ratio (mandatory from Jan 2025)
- **Investment details:** minimum amount, plans/options, loads, expenses, systematic facilities',12,1,26) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z4','nism-5a','nism-5a-m5','Chapter 5 practice',20,50,0,0,0,1,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q0','nism-5a-z4','In the Risk-o-meter, the colour for "Very High" risk is:','["Dark Orange","Red","Neon Yellow","Caramel"]',1,'Low – Irish Green; Low to Moderate – Chartreuse; Moderate – Neon Yellow; Moderately High – Caramel; High – Dark Orange; Very High – Red.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q1','nism-5a-z4','The annual report must be emailed to unitholders within ___ of 31 March.','["1 month","10 days","4 months","6 months"]',2,'Physical copy on request.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q2','nism-5a-z4','The fund factsheet is:','["Issued daily","Monthly and non-mandatory (AMFI best practice)","Mandatory by law","Prepared by SEBI"]',1,'SEBI disclosure rules still apply.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q3','nism-5a-z4','The NAV of open-ended schemes is disclosed:','["Monthly","Annually","Every business day on AMC and AMFI websites","Weekly"]',2,'Liquid and overnight funds also declare NAV on Sundays/holidays.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q4','nism-5a-z4','The Statement of Additional Information (SAI) is:','["One document covering all schemes of a mutual fund","Prepared by the distributor","Scheme-specific","Prepared by AMFI"]',0,'The SAI is legally part of the SID.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q5','nism-5a-z4','TER equals:','["Advisory fee only","Distributor commission only","Entry load + exit load","Base expense ratio + brokerage + transaction cost + statutory levies"]',3,'From 1 Apr 2026: BER + execution brokerage + statutory levies such as GST.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q6','nism-5a-z4','The Key Information Memorandum (KIM) must:','["Be issued only for NFOs","Be sent only on request","Accompany every application form","Be filed with RBI"]',2,'KIM is a summary of SID and SAI.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q7','nism-5a-z4','Mutual fund portfolios must be disclosed on websites within:','["1 year","30 days","3 months","10 days of month-end/half-year"]',3,'Debt schemes also disclose a fortnightly portfolio within 5 days.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q8','nism-5a-z4','A change in Base Expense Ratio must be communicated to investors at least ___ in advance.','["1 day","30 days","3 working days","1 week"]',2,'By email/SMS and a website notice.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q9','nism-5a-z4','A change in fundamental attributes requires all EXCEPT:','["Prior approval of AMFI","Details on the AMC website","Written communication to each unitholder","Exit option at prevailing NAV without exit load"]',0,'Per Regulation 22(9)(c).',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q10','nism-5a-z4','After the launch of an open-ended scheme, the SID must first be updated within ___ of the half-year end.','["3 months","1 month","6 months","1 year"]',2,'Then within 1 month of each half-year (Sept/Mar).',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q11','nism-5a-z4','NAV of close-ended schemes must be disclosed at least:','["Daily","Monthly","Quarterly","Once a week"]',3,'Per disclosure norms.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q12','nism-5a-z4','SEBI does the following with the Scheme Information Document:','["Guarantees it","Vets it (gives observations); it does not approve it","Prepares it","Approves it"]',1,'The SID carries a standard clause that SEBI neither approves nor recommends the scheme.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q13','nism-5a-z4','The SAI must be updated within ___ of every financial year end.','["6 months","1 month","3 months","1 year"]',2,'Material changes are updated on an ongoing basis.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q14','nism-5a-z4','The three mandatory scheme-related documents are:','["SID, TER and CAS","KYC, KIM and CAS","SID, SAI and KIM","SAI, SEBI circular and factsheet"]',2,'The fund factsheet is non-mandatory.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q15','nism-5a-z4','Which of the following is a fundamental attribute of a scheme?','["Daily NAV","Name of the distributor","Type of scheme and investment objective","The fund manager''s salary"]',2,'Also the terms of issue.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q16','nism-5a-z4','The Risk-o-meter is evaluated:','["Daily","Annually","Quarterly","Monthly"]',3,'Changes require a notice-cum-addendum and an email/SMS.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m6','nism-5a','Ch 6: Fund Distribution and Channel Management Practices',6,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-nAwcRqSLALo','nism-5a','nism-5a-m6','Video lesson: Chapter 6: Fund Distribution','video','nAwcRqSLALo','',40,'N V Finance',1,27) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l28','nism-5a','nism-5a-m6','Summary notes 1/4: Role and Kinds of Distributors to MF Utilities & MF Central','note','## Role and Kinds of Distributors

- **Role of Mutual Fund Distributors**

- Two professionals between investor and portfolio: Distributor and Fund manager
- Fund manager analyses markets (company, industry, economy, liquidity, sentiment) → builds scheme portfolio
- Distributor analyses the investor (needs, limits, resources, goals) → asset allocation → suitable schemes
- Both help the investor achieve financial goals

- **Kinds of Distributors**

- **Individual channel:** long history via LIC & UTI agents; often single-handed
- **Non-individual:** partnerships, regional & national distributors, NBFCs, banks, stock brokers
  - Institutional distributors = distribution companies & banks
  - **Model:** own branches & employees (fixed costs, salary) or sub-agents (variable cost, commission)
- **Banks:** MNC banks first, then private, PSU & co-operative banks; segments – retail, wealth/priority/private banking
- **NBFCs & brokers:** employees or sub-agents (agency channel)
- E-commerce & online distributors – no physical office; Execution Only Platform guidelines apply

## Modes of Distribution

- **Physical:** paper forms deposited at Official Points of Acceptance (OPOAs)
- **Digital:** internet & mobile; hybrid mode also common
- Online channel partners – distributor websites, no geographic limits
- Distributor apps (computer & mobile); AMC web/mobile apps, SMS, WhatsApp (direct with MF)
- New-age platforms (e.g. Groww, Kuvera, Paytm Money, Coin) – low cost, often direct plans

## Stock Exchange Platforms

- **NSE:** NMF II (versions for trading members & distributors); BSE: StAR MF
- Trading members registered with AMFI & empanelled with MF can transact; clearing members too; DPs – redemptions only
- AMFI-registered distributors may take limited-purpose membership
- Eligible schemes notified by MFs – not listed on exchange
- Exchange is an order-routing system – not a substitute for RTAs; no settlement guarantee (AMC responsible); exchange grievance mechanism available
- Since Feb 2020 investors can access exchange infrastructure directly
- Units credited to demat; supports SIP, STP, SWP, switch

## MF Utilities & MF Central

- **MF Utilities (MFU):** aggregator connecting investors, RTAs, distributors, banks, AMCs
  - Common Account Number (CAN) – needs KYC (MFU facilitates)
  - Common Transaction Form; single payment for multiple schemes; neutral Points of Service
  - Holdings mapped by PAN & holding pattern; multiple CANs possible
  - Bank & nomination details in CAN override folio details
- MF Central (CAMS + KFintech, under SEBI mandate; live since 31 Dec 2021)
  - Consolidated view (demat & non-demat), service requests (bank, contact, KYC, nominee)
  - Transactions (lump sum, SIP, redemption, switch), folio consolidation, minor-to-major, FATCA
  - CAS, unclaimed amounts, family portfolio tracking',12,1,28) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l29','nism-5a','nism-5a-m6','Summary notes 2/4: Becoming a Distributor to Additional Commission & Transaction Charges','note','## Becoming a Distributor

- **Who:** individuals, banks, NBFCs, distribution companies (AMC appoints)
- NISM Series V-A certification mandatory for anyone selling MFs
  - **Exemption route:** age ≥ 50 or ≥ 10 yrs experience as on 31 May 2010 → CPE credits instead
- Eligible distributors may also offer SIF products if additional criteria met
- **Know Your Distributor (KYD):** PAN + address proof at CAMS PoS + biometric (right index finger); acknowledgement sent to AMCs
  - New cadre (V-B) exempt from biometrics – only ID & address proof
- Obtain ARN from AMFI; minimum age 18
- Empanel with any number of AMCs or work as agent of an empanelled distributor
- **Employees of institutions:** pass V-A and get EUIN (quote in forms); work under firm''s ARN
- From 1 Oct 2024: ARN & EUIN applications only online via AMFI website

## Empanelment with AMCs

- **Request for Empanelment Form:** personal info, ARN, PAN, tax status; key people; business details; bank details for direct credit; nominee
- Declaration:
  - Information correct; keep transactions confidential
  - Follow AMC instructions and statutory codes
  - Use only AMC-provided/approved advertising
  - Show risk factors with performance
  - All selling staff have EUIN
  - No rebating of commission or gifts
  - AMC may terminate empanelment any time
- No standard format – each AMC has its own; some empanel only high-volume distributors

## Distributor Revenue: Trail Commission

- Paid only on Regular plans; no commission on direct plans or own investments
- **SEBI Master Circular (20 Mar 2026):** full trail model – no upfront commission or upfronting of trail, in cash or kind (Reg 66(6))
- Trail = % of net assets attributable to units sold; calculated on daily balances; paid monthly/quarterly
- Rises with NAV; paid as long as investor stays invested
- Daily trail = AUM × trail rate p.a. ÷ 365
- **Example:** ₹10 lakh at 1% p.a. → ~₹27.40/day; August total ≈ ₹853
- Must disclose commissions from competing schemes recommended
- Change of distributor → no trail to either for 12 months

## Additional Commission & Transaction Charges

- Additional commission for new investors (new PAN, industry level):
  - New individual investors from B-30 cities
  - New women investors from Top-30 and B-30 cities

| Mode | Additional commission |
| --- | --- |
| Lump sum | 1% of first application, max ₹2,000 – if invested ≥ 1 year |
| SIP | 1% of first-year investment, max ₹2,000 |

- Paid from the 2 bps of daily net assets set aside for investor education; claw-back applies; over & above trail
- No dual incentive for the same investor/investment
- Transaction charges (earlier for > ₹10,000) withdrawn Aug 2025 – no deduction from investor; AMC pays distributor
  - Upfronting of trail allowed only for SIP inflows',12,1,29) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l30','nism-5a','nism-5a-m6','Summary notes 3/4: GST on Commission & Commission Disclosure to Nomination for Distributors','note','## GST on Commission & Commission Disclosure

- GST (from July 2017) payable if annual turnover > ₹20 lakh
- Registered distributor raises invoice and pays GST
- Unregistered supplier → registered recipient (AMC) pays under reverse charge (Sec 9(4) CGST, 5(4) IGST)
- AMCs disclose commission paid to distributors meeting any of:
  - > 20 locations
  - AUM > ₹100 crore (non-institutional incl. HNI) across industry
  - Commission > ₹1 crore p.a. across industry
  - Commission > ₹50 lakh from a single MF
- **Also yearly:** distributor-wise gross & net inflows, AAUM, AUM/gross inflow ratio; associate status flagged
- Portfolio turnover > 2× industry average → extra due diligence; data to AMFI

## Due Diligence by AMCs on Distributors

- Applies to distributors meeting the same four thresholds (20 locations / ₹100 cr AUM / ₹1 cr / ₹50 lakh)
- Done at empanelment and periodically – ''fit and proper'' check:
  - Business model, experience, proficiency
  - Record of levies, fines, penalties, suits, compensations & corrective action
  - Review of associates and subsidiaries
  - Controls delinking customer risk evaluation & scheme appropriateness from sales staff
- **Also reviewed:** product review criteria, customer risk factors, internal audit of exceptions, staff training & certification, onboarding & grievance handling, audit observations, investor sample surveys

## Distributor vs Investment Adviser

- **Investment adviser:** paid for advice; excludes AMFI-registered MFD giving advice incidental to distribution
- MFD cannot call itself an investment adviser or financial planner; RIA cannot earn both fees and commission
- Only two transaction types – no third category:
  - **Advisory:** sell only ''appropriate'' products within customer''s risk ceiling – no exceptions
  - **Execution only:** if unsuitable, written communication acknowledged by investor + confirmation; no extra charge
- Disclose conflict of interest when selling group/associate products
- **Mis-selling (PFUTP Regulations 2003):** false/misleading statement; concealing material facts; concealing risk factors; not ensuring suitability

## Nomination for Distributors

- AMCs offer nomination at empanelment (AMFI uniform practice)
- **On death of MFD:** commission to nominee, else legal heirs (with heirship documents)
  - Nominee need not hold ARN; receives as trustee for legal heirs
  - Only on assets procured while ARN was valid & not suspended
  - Paid until investor changes ARN or AUM under that ARN becomes nil
  - No new business or new/changed systematic transactions under deceased''s ARN
- Intimate AMFI with attested death certificate → AMFI informs AMCs (not for overseas distributors)
- **Transfer of AUM to nominee/heir:** needs investor request or valid ARN + KYD; clients informed, 15 days to object',12,1,30) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l31','nism-5a','nism-5a-m6','Summary notes 4/4: Change of Distributor','note','## Change of Distributor

- Investor can change distributor or go direct – written request, no NOC
- Investor-initiated change → no trail to old or new distributor; new one may be paid after 12-month cooling-off
- **Exception:** change due to voluntary cessation of business by distributor – new distributor gets trail
- Distributor-initiated change allowed only for:
  - Change in name/legal status (individual → firm → LLP etc.)
  - Merger/acquisition/consolidation within same group
  - AUM consolidation within family/close relatives
  - Transfer of business by individual distributors
- Entire AUM must move to a valid, KYD-compliant ARN holder; old ARN surrendered',3,1,31) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z5','nism-5a','nism-5a-m6','Chapter 6 practice',30,50,0,0,0,1,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q0','nism-5a-z5','Know Your Distributor (KYD) involves:','["A bank guarantee","PAN and address proof plus biometric (right index finger)","A demat account","An exam only"]',1,'New cadre (V-B) is exempt from biometrics.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q1','nism-5a-z5','A distributor cannot call itself:','["An investment adviser or financial planner","An empanelled partner","A mutual fund distributor","An ARN holder"]',0,'MFD advice must be incidental to distribution.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q2','nism-5a-z5','A distributor has ₹22,00,000 of client AUM in regular plans with a trail rate of 1% p.a. The approximate daily trail commission is:','["₹723.29","₹60.27","₹1,808.22","₹1,833.33"]',1,'Daily trail = AUM × rate ÷ 365 = ₹60.27.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q3','nism-5a-z5','Daily trail commission is calculated as:','["AUM × trail rate ÷ 12 ÷ 100","Units × face value","AUM × trail rate p.a. ÷ 365","NAV × units"]',2,'Paid monthly or quarterly.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q4','nism-5a-z5','As per the SEBI Master Circular (March 2026), distributor commission follows:','["A full trail model with no upfront commission","A fixed salary model","An entry load model","An upfront commission model"]',0,'Upfronting of trail is allowed only for SIP inflows.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q5','nism-5a-z5','The minimum age for obtaining an ARN is:','["18 years","21 years","25 years","16 years"]',0,'ARN application is online via AMFI from 1 Oct 2024.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q6','nism-5a-z5','A distributor has ₹21,00,000 of client AUM in regular plans with a trail rate of 0.75% p.a. The approximate daily trail commission is:','["₹1,312.50","₹43.15","₹517.81","₹1,294.52"]',1,'Daily trail = AUM × rate ÷ 365 = ₹43.15.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q7','nism-5a-z5','A Registered Investment Adviser (RIA) cannot:','["Earn both advisory fees and commission","Charge advisory fees","Use a risk profile","Advise on mutual funds"]',0,'Only two transaction types exist: advisory and execution-only.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q8','nism-5a-z5','A distributor has ₹24,00,000 of client AUM in regular plans with a trail rate of 1.25% p.a. The approximate daily trail commission is:','["₹2,465.75","₹2,500.00","₹986.30","₹82.19"]',3,'Daily trail = AUM × rate ÷ 365 = ₹82.19.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q9','nism-5a-z5','A distributor has ₹10,00,000 of client AUM in regular plans with a trail rate of 1% p.a. The approximate daily trail commission is:','["₹833.33","₹821.92","₹328.77","₹27.40"]',3,'Daily trail = AUM × rate ÷ 365 = ₹27.40.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q10','nism-5a-z5','A distributor has ₹63,00,000 of client AUM in regular plans with a trail rate of 1.5% p.a. The approximate daily trail commission is:','["₹7,875.00","₹258.90","₹3,106.85","₹7,767.12"]',1,'Daily trail = AUM × rate ÷ 365 = ₹258.90.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q11','nism-5a-z5','A distributor has ₹11,00,000 of client AUM in regular plans with a trail rate of 0.75% p.a. The approximate daily trail commission is:','["₹678.08","₹687.50","₹22.60","₹271.23"]',2,'Daily trail = AUM × rate ÷ 365 = ₹22.60.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q12','nism-5a-z5','On the death of an MFD, commission on the assets procured is paid to:','["The AMC","The investor","The nominee, else legal heirs","AMFI"]',2,'Nominee receives as trustee for legal heirs.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q13','nism-5a-z5','If an investor changes the distributor, the trail commission:','["Is not paid to either distributor for 12 months","Goes to the old distributor forever","Goes to the AMC","Is doubled"]',0,'New distributor may be paid after the 12-month cooling-off.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q14','nism-5a-z5','Additional commission for new investors (B-30 individuals, women) on lump sum is:','["0.5% maximum ₹500","3% maximum ₹10,000","1% of the first application, maximum ₹2,000","2% maximum ₹5,000"]',2,'SIP: 1% of the first-year investment, maximum ₹2,000.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q15','nism-5a-z5','Employees of institutional distributors must obtain:','["CAN","SCORES ID","EUIN","OTM"]',2,'EUIN must be quoted in forms.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q16','nism-5a-z5','A distributor has ₹41,00,000 of client AUM in regular plans with a trail rate of 1.5% p.a. The approximate daily trail commission is:','["₹2,021.92","₹5,125.00","₹5,054.79","₹168.49"]',3,'Daily trail = AUM × rate ÷ 365 = ₹168.49.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q17','nism-5a-z5','The mandatory certification for those selling mutual funds is:','["NISM Series XV","NISM Series VIII","NISM Series V-A","NISM Series IV"]',2,'NISM Series V-B is the foundation (new cadre) certification.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q18','nism-5a-z5','A distributor has ₹77,00,000 of client AUM in regular plans with a trail rate of 0.75% p.a. The approximate daily trail commission is:','["₹1,898.63","₹158.22","₹4,812.50","₹4,746.58"]',1,'Daily trail = AUM × rate ÷ 365 = ₹158.22.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q19','nism-5a-z5','A distributor has ₹25,00,000 of client AUM in regular plans with a trail rate of 1% p.a. The approximate daily trail commission is:','["₹821.92","₹2,054.79","₹68.49","₹2,083.33"]',2,'Daily trail = AUM × rate ÷ 365 = ₹68.49.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q20','nism-5a-z5','A distributor has ₹74,00,000 of client AUM in regular plans with a trail rate of 1.5% p.a. The approximate daily trail commission is:','["₹9,123.29","₹9,250.00","₹3,649.32","₹304.11"]',3,'Daily trail = AUM × rate ÷ 365 = ₹304.11.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q21','nism-5a-z5','GST on distributor commission is payable when annual turnover exceeds:','["₹20 lakh","₹1 crore","₹40 lakh","₹10 lakh"]',0,'Reverse charge applies to unregistered suppliers.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q22','nism-5a-z5','Commission is paid only on:','["Direct plans","Overnight funds only","Own investments by the distributor","Regular plans"]',3,'No commission on direct plans.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q23','nism-5a-z5','The law under which mis-selling is addressed is the:','["Negotiable Instruments Act","Companies Act","SEBI (PFUTP) Regulations, 2003","Contract Act"]',2,'Prohibition of Fraudulent and Unfair Trade Practices.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q24','nism-5a-z5','A distributor has ₹48,00,000 of client AUM in regular plans with a trail rate of 1.25% p.a. The approximate daily trail commission is:','["₹4,931.51","₹5,000.00","₹1,972.60","₹164.38"]',3,'Daily trail = AUM × rate ÷ 365 = ₹164.38.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m7','nism-5a','Ch 7: NAV, Total Expense Ratio and Pricing of Units',8,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-KSGriBaTAD0','nism-5a','nism-5a-m7','Video lesson: Chapter 7: Net Asset Value, Total Expense Ratio & Pricing Units','video','KSGriBaTAD0','',47,'N V Finance',1,32) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l33','nism-5a','nism-5a-m7','Summary notes 1/3: Fair Valuation Principles (1/2) to Net Asset Value: Formula and Worked Examples','note','## Fair Valuation Principles (1/2)

- **Goal:** fair treatment of existing, incoming and exiting investors; reduce mispricing & redemption pressure
- Valuation per Seventh Schedule of SEBI (MF) Regulations 2026
- P1: Value at realisable (fair) value, in good faith, true & fair
- P2: AMC Board-approved methodology for each security type; new security types only after method approved
- P3: Consistent valuation; process for exceptional events when quotes unreliable
- P4: Periodic review; independent auditor reviews policy at least once a financial year; boards updated
- P5: Policies must address conflict of interest

## Fair Valuation Principles (2/2)

- P6: Disclose valuation policy in SAI, AMC website and as specified
- P7: AMC responsible for true & fair valuation – may deviate from policy to reach fair value, with reporting to boards & disclosure to investors
- P8: Policies to detect and prevent incorrect valuation
- P9: Document rationale incl. inter-scheme transfers – audit trail
- P10: Debt & money market – consider trades of same/similar security on all public platforms
- Fair Valuation Principles prevail over Valuation Guidelines in any conflict
- Guidelines cover traded, non-traded & thinly traded securities, gold/silver, illiquidity adjustments

## Net Assets of a Scheme – Example

- 20 crore units × ₹10 = ₹200 cr; ₹140 cr in equity (+10%); ₹60 cr in deposits/money market
- Income ₹8 cr; expenses paid ₹4 cr; expenses payable ₹1 cr

| Liabilities | ₹ cr | Assets | ₹ cr |
| --- | --- | --- | --- |
| Unit capital | 200 | Equity at market value | 154 |
| Profits (8 − 4 − 1) | 3 | Deposits & money market (60 + 8 − 4) | 64 |
| Capital appreciation | 14 |  |  |
| Unitholders'' funds (Net assets) | 217 |  |  |
| Expenses payable | 1 |  |  |
| Total | 218 | Total | 218 |

- Net assets = amount invested + profits booked + portfolio appreciation (even unrealised)
- **Accrual principle:** income/expenses for the period counted whether received/paid or not

## Net Asset Value: Formula and Worked Examples

- **Net Asset Value (NAV)**

- NAV = Net assets ÷ Units outstanding = 217 ÷ 20 = ₹10.85
- Or (Total assets − Liabilities other than to unitholders) ÷ Units = (218 − 1) ÷ 20 = ₹10.85
- NAV rises with income & gains; falls with expenses & losses
- Profit = Interest + Dividend + Realised gains + Valuation gains − Realised losses − Valuation losses − Expenses
- Current liabilities may include payables for securities bought and borrowings ≤ 6 months (also intra-day borrowing repaid same day)

- **NAV – Worked Examples**

- Example 1: Stocks 150 + Bonds 67 + Money market 2.36 + Dividend accrued 1.09 + Interest accrued 2.68 − Fees payable 0.36 = 222.77
  - ÷ 1.90 crore units → NAV = ₹117.25
- Example 2: Stocks 230 + Money market 5 + Dividend accrued 2.39 + Receivable on sale 2.34 − Payable on purchase 7.5 − Fees 0.41 = 231.82
  - ÷ 2.65 crore units → NAV = ₹87.48
- **General formula:** (Investments at market value + Accrued income + Current assets − Current liabilities − Accrued expenses) ÷ Units',12,1,33) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l34','nism-5a','nism-5a-m7','Summary notes 2/3: Why Mark to Market? to TER for Fund of Funds & Extra Charges','note','## Why Mark to Market?

- NAV must reflect true worth – valuing a ₹50 share at cost ₹15 is meaningless
- **Example:** Net assets ₹1,50,000; 10,000 units; NAV ₹15

| Case | Effect |
| --- | --- |
| Issue 100 units at face value ₹10 (below NAV) | NAV falls to ₹14.95 – hurts existing investors |
| Redeem 100 units at ₹10 (below NAV) | NAV rises to ₹15.05 – exiting investor loses |

- MTM ensures fair buy/sell prices and helps assess fund manager performance

## Scheme Expenses

- All expenses must be identified and paid from the scheme within base expense limits, brokerage limits, transaction cost & statutory levy
- Excess over limits borne by AMC, trustees or sponsor
- Investment & advisory fee charged by AMC – disclosed in SID
- **Recurring expenses:** marketing & distribution, brokerage, RTA, trustee fees, audit, custodian, investor communication, fund transfer, statements & payouts, insurance, winding-up, statutory ads, gold/silver/commodity storage, listing fees, others approved by SEBI
- Equity-oriented for TER = ≥ 65% in equity (other than index fund/ETF)

## Total Expense Ratio Limits

| Daily net assets slab | Equity-oriented | Other schemes |
| --- | --- | --- |
| First ₹500 cr | 2.10% | 1.85% |
| Next ₹250 cr | 1.90% | 1.65% |
| Next ₹1,250 cr | 1.60% | 1.40% |
| Next ₹3,000 cr | 1.50% | 1.25% |
| Next ₹5,000 cr | 1.40% | 1.15% |
| Next ₹40,000 cr | −0.05% per ₹5,000 cr | −0.05% per ₹5,000 cr |
| Balance | 0.95% | 0.70% |

- **Index funds / ETFs:** max 0.90%
- **Close-ended & interval:** equity 1.00%; others 0.80%

## TER for Fund of Funds & Extra Charges

| FoF type | Max TER (incl. underlying) |
| --- | --- |
| Investing in liquid, index funds, ETFs | 0.90% |
| ≥ 65% in equity-oriented schemes | 2.10% |
| Others | 1.85% |

- FoF''s own TER ≤ 2× weighted average TER of underlying schemes (within ceilings)
- Brokerage & transaction cost over limits: 0.06% (cash market), 0.02% (derivatives) of trade value
- TER = base expense + brokerage + transaction cost + statutory levies
- Nothing else may be charged except exit load & specified levies
- Daily TER disclosed on AMC & AMFI websites',12,1,34) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l35','nism-5a','nism-5a-m7','Summary notes 3/3: IDCW & Distributable Reserves to Accounting, Segregated Portfolio & Perpetual Bonds','note','## IDCW & Distributable Reserves

- Valuation gains are only on paper – not certain until sold
- IDCW paid only out of distributable reserves:
  - All accrued profits are distributable
  - Valuation gains ignored; valuation losses deducted
  - Portion of sale price of new units attributable to valuation gains not distributable
- **Equalisation reserve:** realised-gain portion of sale price can fund IDCW → part of IDCW is investor''s own capital; MF must show income vs capital split
- No guarantee of rate or regularity of IDCW

## IDCW Declaration Process

- Trustees decide quantum and record date (may delegate to AMC for up to monthly frequency; ratified at next board meeting)
- Record date = cut-off for eligibility from register of unitholders; NAV adjusted at end of record date
- Public notice within 1 day of trustee decision; record date 5 calendar days from notice
- Notice must state NAV will fall by payout + statutory levy
- Delay in payment → interest from record date
- No notice needed for liquid/debt schemes with daily-to-monthly IDCW (disclosed in SID)
- Listed schemes follow listing agreement

## Entry & Exit Loads

- Entry load (sale price above NAV) – banned; sale price = NAV (less stamp duty)
  - e.g. ₹25,000 at NAV ₹43.21 → 578.570 units
- **Exit load:** repurchase price below NAV
  - NAV ₹11, exit load 1% → repurchase price ₹10.89
  - May reduce with holding period (3% yr 1, 2% yr 2 …)
- No distinction between investors by amount; changes apply only to prospective investments
- No exit load on bonus units or IDCW reinvestment units
- Exit load credited back to the scheme (not for AMC selling expenses)

## Accounting, Segregated Portfolio & Perpetual Bonds

- **Accounting, Reporting & Segregated Portfolio**

- Scheme accounts separate from AMC accounts; different auditors
- Norms on when interest, dividends, bonus, rights are recognised
- **NAV decimals:** 4 places for index, liquid & debt funds; at least 2 for equity & balanced
- Fractional units allowed; exchanges may restrict to whole units
- Segregated portfolio (credit event / actual default on unrated issuer debt):
  - No investment & advisory fee on segregated portfolio
  - Other TER charged pro-rata only on recovery
  - NAV declared daily; disclosed in scheme documents, portfolio disclosures & annual report

- **Perpetual Bonds (AT-1 / Tier 2)**

- Bank-issued perpetual bonds; absorb losses before equity / may convert to equity on trigger
- SEBI caps fund exposure to these bonds
- AT-1 bonds valued on Yield to Call basis',12,1,35) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z6','nism-5a','nism-5a-m7','Chapter 7 practice',30,50,0,0,0,1,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q0','nism-5a-z6','AT-1 bonds are valued on:','["Cost basis","Yield to Call basis","Yield to maturity only","Face value"]',1,'SEBI caps fund exposure to perpetual bonds.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q1','nism-5a-z6','A Fund of Funds investing in liquid funds, index funds or ETFs can have a maximum TER (including underlying) of:','["1.00%","1.85%","0.90%","2.10%"]',2,'FoFs investing ≥65% in equity-oriented schemes: 2.10%; others 1.85%.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q2','nism-5a-z6','The notice of IDCW must state that:','["Units will be cancelled","Returns are guaranteed","NAV will fall by the payout plus statutory levy","NAV will rise"]',2,'This applies to non-liquid schemes.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q3','nism-5a-z6','Net assets of a scheme equal:','["Realised profits only","AUM minus loads","Amount invested + profits booked + portfolio appreciation (even unrealised)","Amount invested only"]',2,'This uses the accrual principle.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q4','nism-5a-z6','A scheme with average net assets of ₹3800 crore incurs total recurring expenses of ₹4.10 crore in a year. Its expense ratio is:','["0.216%","0.108%","0.054%","0.162%"]',1,'TER = 4.10 ÷ 3800 × 100 = 0.108%.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q5','nism-5a-z6','Entry load in mutual funds:','["Is charged by AMFI","Is banned; sale price equals NAV","Is allowed for distributors","Is allowed up to 2.25%"]',1,'Entry load was banned in 2009.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q6','nism-5a-z6','A scheme has total assets of ₹134.40 crore, liabilities (other than to unitholders) of ₹3.40 crore and 1.40 crore units outstanding. Its NAV per unit is:','["₹98.43","₹54.58","₹93.57","₹96.00"]',2,'NAV = (134.40 − 3.40) ÷ 1.40 = ₹93.57.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q7','nism-5a-z6','The maximum TER for equity-oriented schemes on the first ₹500 crore of daily net assets is:','["1.85%","2.10%","2.25%","2.50%"]',1,'Other schemes: 1.85%.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q8','nism-5a-z6','Extra brokerage and transaction cost over the limits is allowed at:','["0.06% (cash market) and 0.02% (derivatives) of trade value","0.50% and 0.25%","1% and 0.5%","0.01% and 0.10%"]',0,'Within the TER ceilings.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q9','nism-5a-z6','A scheme with average net assets of ₹2100 crore incurs total recurring expenses of ₹7.00 crore in a year. Its expense ratio is:','["0.667%","0.332%","0.333%","0.167%"]',2,'TER = 7.00 ÷ 2100 × 100 = 0.333%.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q10','nism-5a-z6','A scheme has an NAV of ₹20.90 and an exit load of 0.5%. The redemption (repurchase) price per unit is:','["₹21.00","₹20.40","₹20.90","₹20.80"]',3,'Repurchase price = 20.90 × (1 − 0.5%) = ₹20.80.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q11','nism-5a-z6','A scheme has total assets of ₹182.40 crore, liabilities (other than to unitholders) of ₹5.10 crore and 1.60 crore units outstanding. Its NAV per unit is:','["₹110.81","₹114.00","₹117.19","₹68.19"]',0,'NAV = (182.40 − 5.10) ÷ 1.60 = ₹110.81.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q12','nism-5a-z6','The maximum TER for index funds/ETFs is:','["0.90%","0.50%","2.10%","1.00%"]',0,'Close-ended and interval: equity 1.00%, others 0.80%.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q13','nism-5a-z6','Mark-to-market ensures that when units are issued below NAV:','["The distributor is rewarded","Existing investors would otherwise be hurt","The NAV rises","The AMC earns more"]',1,'In the example, NAV falls to ₹14.95.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q14','nism-5a-z6','IDCW can be paid only out of:','["Capital only","Distributable reserves","Unrealised gains","Entry loads"]',1,'Valuation gains are ignored; valuation losses are deducted.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q15','nism-5a-z6','NAV of index, liquid and debt funds must be declared to at least ___ decimal places.','["4","3","2","6"]',0,'At least 2 for equity and balanced funds.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q16','nism-5a-z6','Exit load is NOT charged on:','["Bonus units and IDCW reinvestment units","Lump sum purchases","Units redeemed in 1 week","SIP units"]',0,'Per exit-load norms.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q17','nism-5a-z6','A scheme with average net assets of ₹600 crore incurs total recurring expenses of ₹5.30 crore in a year. Its expense ratio is:','["0.883%","0.442%","0.876%","1.767%"]',0,'TER = 5.30 ÷ 600 × 100 = 0.883%.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q18','nism-5a-z6','A segregated portfolio is created on:','["A credit event or actual default on unrated or rated debt as specified","IDCW declaration","A distributor change","Every NFO"]',0,'No investment and advisory fee is charged on it.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q19','nism-5a-z6','The record date for IDCW is how many days from the notice?','["10 working days","5 calendar days","30 days","1 day"]',1,'Public notice within 1 day of the trustee decision.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q20','nism-5a-z6','Exit load is:','["Retained by the AMC","Credited back to the scheme","Paid to SEBI","Paid to the distributor"]',1,'It cannot be used for AMC selling expenses.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q21','nism-5a-z6','NAV per unit is:','["Total assets ÷ number of investors","Face value × units","Net assets × units","Net assets ÷ units outstanding"]',3,'NAV = (Assets − Liabilities other than to unitholders) ÷ units.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q22','nism-5a-z6','With NAV of ₹11 and exit load of 1%, the repurchase price is:','["₹10.89","₹11.11","₹11.00","₹10.00"]',0,'11 × (1 − 0.01) = ₹10.89.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q23','nism-5a-z6','The maximum TER for an equity-oriented scheme on the next ₹250 crore is:','["1.60%","1.90%","2.10%","2.25%"]',1,'Other schemes: 1.65%.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q24','nism-5a-z6','The accrual principle means income and expenses are counted:','["Only when paid","Only on redemption","Only when received","For the period whether received/paid or not"]',3,'Core accounting principle.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m8','nism-5a','Ch 8: Taxation',4,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-GLq8szwqf3s','nism-5a','nism-5a-m8','Video lesson: Chapter 8: Taxation','video','GLq8szwqf3s','',32,'N V Finance',1,36) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l37','nism-5a','nism-5a-m8','Summary notes 1/2: Taxation: Two Levels to Taxation of IDCW','note','## Taxation: Two Levels

- "Not how much you earn, but how much you keep after taxes"
- Mutual fund = pass-through vehicle → consider income of the fund and of the investor
- Fund income (interest, dividend, capital gains) exempt under Sec 10(23D) – MF is a trust for unitholders
- Investor income:
  - Growth option → capital gains on sale only
  - IDCW option → IDCW when declared + capital gains on sale
- **Tax depends on:** type of income, holding period, type of scheme, type of investor
- **Equity-oriented scheme for tax:** > 65% in domestic listed equity shares (FoF of equity funds = non-equity)
- **Joint holding:** income taxed in hands of first holder

## Capital Gains on Equity-oriented Funds

- **Grandfathering:** gains up to 31 Jan 2018 exempt – cost = higher of purchase price or NAV on 31 Jan 2018
  - ₹1 lakh invested, ₹2 lakh on 31 Jan 2018, sold at ₹1.8 lakh → LTCG = 0
  - Sold at ₹2.2 lakh → LTCG = ₹20,000
- **LTCG exemption:** first ₹1.25 lakh per financial year tax-free
  - LTCG ₹90,000 → nil tax; ₹1,35,000 → tax on ₹10,000

## Tax Rates for Unitholders

| Scheme type | STCG | LTCG | LTCG holding period |
| --- | --- | --- | --- |
| Equity-oriented (incl. hybrid > 65% equity) | 20% | 12.5% (₹1.25 lakh exempt) | > 12 months |
| Debt-oriented (incl. hybrid > 65% debt) | Slab rate | Slab rate | – |
| Hybrid with 35–65% domestic equity | Slab rate | 12.5% | > 24 months |
| Other MFs (FoFs, international) | Slab rate | 12.5% | > 24 months |
| Equity ETFs | Slab rate | 12.5% | > 12 months |
| Gold ETFs | Slab rate | 12.5% | > 12 months |
| Debt ETFs | Slab rate | Slab rate | – |

- Rates as stated in the workbook (Sept 2026)

## Taxation of IDCW

- Till FY 2019-20: IDCW tax-free for investor; Dividend Distribution Tax (DDT) deducted by the scheme
- From April 2020: DDT abolished; IDCW added to income and taxed at investor''s slab rate
  - Higher-income investors pay more; tax-exempt investors (charitable trusts, low-slab individuals) benefit
  - New regime allows exemptions/adjustments; DDT could not be set off
- NAV still falls by the full payout – post-tax receipt is lower than NAV drop
- Growth option is more tax-efficient – tax deferral, compounding pre-tax
- From 1 April 2021: IDCW must be split into income distribution (NAV appreciation) and capital distribution',12,1,37) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l38','nism-5a','nism-5a-m8','Summary notes 2/2: Stamp Duty and Securities Transaction Tax to TDS and GST','note','## Stamp Duty and Securities Transaction Tax

- **Stamp Duty**

- Effective 1 July 2020 (Indian Stamp Act amended Feb 2019)
- 0.005% on issue of units – physical and demat
  - Purchase, additional purchase, IDCW reinvestment, SIP, STP, IDCW transfer plan (incl. old SIP/STP triggers)
  - Units allotted on amount net of stamp duty
- 0.015% on transfer of units (e.g. between demat accounts)

- **Securities Transaction Tax (STT)**

- Only on equity-oriented funds – on redemption/switch/sale; not on purchase; not on debt funds

| Transaction | STT | Payable by |
| --- | --- | --- |
| Purchase of equity MF units | Nil | – |
| Sale of equity MF units on exchange (delivery) | 0.001% | Seller |
| Sale of equity shares/units (non-delivery) | 0.025% | Seller |
| Redemption of equity MF units to the fund | 0.001% | Seller |

## Set-off of Losses & Bonus Stripping

- Capital loss cannot be set off against other heads (e.g. salary)
- Short-term capital loss → against STCG or LTCG
- Long-term capital loss → only against LTCG
- Unabsorbed capital loss carried forward up to 8 years
- **Bonus stripping:** buy at ₹30, 1:1 bonus, sell original at ₹15 → loss ₹15
  - Loss disallowed if bought within 3 months before record date and sold within 9 months after
  - Disallowed loss becomes cost of the bonus units
  - Invest for fundamentals, not tax tricks

## Section 80C – ELSS

- **ELSS (Tax Saver):** deduction up to ₹1.5 lakh per year for individuals & HUFs – Old Tax Regime only
- 3-year lock-in from date of each investment
  - Limit shared with other 80C avenues – lock-in applies even without extra benefit
  - Each SIP instalment locked for 3 years separately
  - IDCW reinvestment also locked in → most AMCs offer only growth/IDCW payout
- Benefit to first holder in joint holding
- **New Tax Regime (Budget 2020):** lower rates, no 80C → ELSS is just a locked-in equity fund
- Some retirement funds also qualify for 80C – 5-year lock-in; check individually
- MF = tax-sheltered vehicle → tax deferral and pre-tax compounding in growth option

## TDS and GST

- No TDS on redemption for residents; TDS applies for certain non-residents (rate by investor, asset & income type)
- **IDCW:** TDS 10% for residents if IDCW exceeds ₹10,000
- **NRIs:** lower of Income Tax rate or DTAA rate – with supporting documents
- GST in schemes:
  - On investment & advisory fees – over and above TER limits
  - On other fees – within TER
  - On exit load – deducted from load, net credited to scheme
  - On brokerage & transaction cost – within TER
- GST on distributor commission – cannot be charged to the scheme
- From 1 Apr 2026: TER = Base Expense Ratio + execution brokerage + statutory levies (e.g. GST)',12,1,38) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z7','nism-5a','nism-5a-m8','Chapter 8 practice',30,50,0,0,0,1,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q0','nism-5a-z7','Gains on units up to which date are grandfathered for equity funds?','["31 March 2018","31 March 2000","31 January 2018","1 April 2020"]',2,'Cost = higher of purchase price or NAV on 31 Jan 2018.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q1','nism-5a-z7','LTCG on equity-oriented mutual funds is taxed at ___ on gains exceeding ₹1.25 lakh in a financial year.','["10%","15%","20%","12.5%"]',3,'Holding period more than 12 months.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q2','nism-5a-z7','STCG on equity-oriented mutual funds is taxed at:','["30%","20%","15%","10%"]',1,'Holding period of up to 12 months.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q3','nism-5a-z7','Stamp duty at 0.005% on issue of units applies to an investment of ₹16,00,000. The stamp duty is:','["₹8,000.00","₹80.00","₹800.00","₹240.00"]',1,'₹1600000 × 0.005% = ₹80.00.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q4','nism-5a-z7','An investor redeems equity-oriented fund units after 8 months with a short-term capital gain of ₹49,000. The STCG tax (ignoring cess) is:','["₹4,900","₹7,350","₹6,125","₹9,800"]',3,'STCG on equity-oriented funds is 20%: ₹9,800.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q5','nism-5a-z7','Stamp duty at 0.005% on issue of units applies to an investment of ₹40,00,000. The stamp duty is:','["₹2,000.00","₹600.00","₹20,000.00","₹200.00"]',3,'₹4000000 × 0.005% = ₹200.00.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q6','nism-5a-z7','GST on a scheme''s investment and advisory fees is:','["Over and above the TER limits","Within the TER","Not applicable","Paid by the distributor"]',0,'GST on distributor commission cannot be charged to the scheme.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q7','nism-5a-z7','An investor sells equity-oriented fund units after 18 months with a long-term capital gain of ₹7,05,000 (no other LTCG in the year). As per the rates in the current workbook, the LTCG tax (ignoring cess) is:','["₹1,16,000","₹88,125","₹72,500","₹1,41,000"]',2,'Taxable = 705000 − 1,25,000; tax at 12.5% = ₹72,500.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q8','nism-5a-z7','A short-term capital loss can be set off against:','["LTCG only","Salary income","No income","STCG or LTCG"]',3,'Long-term loss only against LTCG.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q9','nism-5a-z7','LTCG of ₹1,35,000 on equity funds leads to tax on:','["₹1,25,000","₹25,000","₹1,35,000","₹10,000"]',3,'Tax at 12.5% on ₹10,000 = ₹1,250.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q10','nism-5a-z7','Stamp duty at 0.005% on issue of units applies to an investment of ₹14,00,000. The stamp duty is:','["₹7,000.00","₹70.00","₹210.00","₹700.00"]',1,'₹1400000 × 0.005% = ₹70.00.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q11','nism-5a-z7','Hybrid funds with 35–65% domestic equity attract LTCG at 12.5% after a holding period of:','["More than 24 months","More than 12 months","More than 6 months","More than 36 months"]',0,'STCG at slab rate.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q12','nism-5a-z7','An investor redeems equity-oriented fund units after 8 months with a short-term capital gain of ₹66,000. The STCG tax (ignoring cess) is:','["₹6,600","₹8,250","₹9,900","₹13,200"]',3,'STCG on equity-oriented funds is 20%: ₹13,200.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q13','nism-5a-z7','TDS on IDCW for residents applies if IDCW exceeds ₹10,000 at the rate of:','["10%","5%","30%","20%"]',0,'No TDS on redemption for residents.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q14','nism-5a-z7','Stamp duty on issue of units is:','["0.015%","0.1%","0.001%","0.005%"]',3,'From 1 July 2020; 0.015% on transfer of units.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q15','nism-5a-z7','A person has LTCG of ₹90,000 on equity funds in a year. The tax payable is:','["Nil","₹11,250","₹9,000","₹18,000"]',0,'First ₹1.25 lakh is exempt.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q16','nism-5a-z7','Debt-oriented mutual fund gains are taxed at:','["12.5% LTCG","Slab rates for both short-term and long-term","20% STCG only","Nil"]',1,'Per the Sept 2026 workbook.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q17','nism-5a-z7','STT on redemption of equity MF units is:','["0.025% payable by the buyer","0.1% payable by the buyer","Nil","0.001% payable by the seller"]',3,'STT is not charged on purchase or on debt funds.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q18','nism-5a-z7','An investor sells equity-oriented fund units after 18 months with a long-term capital gain of ₹5,95,000 (no other LTCG in the year). As per the rates in the current workbook, the LTCG tax (ignoring cess) is:','["₹1,19,000","₹58,750","₹74,375","₹94,000"]',1,'Taxable = 595000 − 1,25,000; tax at 12.5% = ₹58,750.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q19','nism-5a-z7','Since April 2020, IDCW is:','["Added to the investor''s income and taxed at slab rate","Tax-free","Taxed at 10% flat","Taxed through DDT in the scheme"]',0,'DDT was abolished.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q20','nism-5a-z7','Unabsorbed capital losses can be carried forward for:','["4 years","8 years","Indefinitely","2 years"]',1,'As per tax rules.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q21','nism-5a-z7','An investor sells equity-oriented fund units after 18 months with a long-term capital gain of ₹6,75,000 (no other LTCG in the year). As per the rates in the current workbook, the LTCG tax (ignoring cess) is:','["₹1,10,000","₹84,375","₹68,750","₹1,35,000"]',2,'Taxable = 675000 − 1,25,000; tax at 12.5% = ₹68,750.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q22','nism-5a-z7','Income of a mutual fund scheme is exempt from tax under:','["Section 80C","Section 112A","Section 10(23D)","Section 194"]',2,'The investor, not the fund, pays tax.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q23','nism-5a-z7','Bonus stripping loss is disallowed if units are bought within ___ before the record date and sold within ___ after.','["3 months; 9 months","9 months; 3 months","1 month; 6 months","6 months; 12 months"]',0,'The disallowed loss becomes the cost of the bonus units.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q24','nism-5a-z7','For tax purposes, an equity-oriented fund is one investing more than ___ in domestic listed equity shares.','["75%","80%","65%","50%"]',2,'A FoF of equity funds is treated as non-equity.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m9','nism-5a','Ch 9: Investor Services',15,9) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort;
