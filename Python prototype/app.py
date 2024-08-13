import datetime
on = True
streak = 0
success = []
print('Welcome to the app')
while on:
  try:
   answer_string = input("Please write a 1 if you still hasn't failed, a 2 if you failed or 3 to quit")
   answer = int(answer_string)
   if answer == 1:
     print('Okay, nice work we logged it')
     streak = streak + 1
     print("You have a " + str(streak) + " streak!")
     date = datetime.datetime.now()
     d_str = date.strftime("%m/%d/%Y")
     if d_str in success:
       print("It's not the first in this day!")
     else:  
       success.append(d_str)
   elif answer == 2:
     streak = 0
     print("You failed and lost your streak. But keep it up and try again")
   elif answer == 3:
     print()
     print()
     print(success)
     on = False
  except:
    print("Please write 1, 2 or 3")
