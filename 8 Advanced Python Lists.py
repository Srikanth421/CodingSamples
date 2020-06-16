
# coding: utf-8

# 1) Filtering Lists with Python

# In[17]:


original_list = [1,2,3,4,5]

def filter_three(number):
    return number > 3

filtered = filter(filter_three, original_list)

filtered_list = list(filtered)

print(filtered_list)
# Returns [4,5]


# In[4]:


filtered_list = [number for number in original_list if number > 3]

print(filtered_list)

# Return [4,5]


# 2)  Modifying Lists

# In[8]:


def square(number):
    return number ** 2

squares = map(square, original_list)

squares_list = list(squares)

print(squares_list)

# Returns [1, 4, 9, 16, 25]


# In[9]:


squares_list = [number ** 2 for number in original_list]

print(squares_list)

# Returns [1,4,9,16,25]


# 3) Combining Lists with the Zip() Function

# In[11]:


numbers = [1,2,3]

letters = ['a', 'b', 'c']

combined = zip(numbers, letters)

combined_list = list(combined)

print(combined_list)
# returns [(1, 'a'), (2, 'b'), (3, 'c')]


# 4) Reversing a List

# In[12]:


original_list = [1,2,3,4,5]

reversed_list = original_list[::-1]

print(reversed_list)

# Returns: [5,4,3,2,1]


# 5) Checking for Membership in a List

# In[13]:


games = ['Yankees', 'Yankees', 'Cubs', 'Blue Jays', 'Giants']

def isin(item, list_name):
    if item in list_name: print(f"{item} is in the list!")
    else: print(f"{item} is not in the list!")

isin('Blue Jays', games)
isin('Angels', games) 

# Returns
# Blue Jays is in the list!
# Angels is not in the list!


# 6) Finding the Most Common Item in a List 

# In[14]:


games = ['heads', 'heads', 'tails', 'heads', 'tails']
items = set(games)
print(max(items, key = games.count))


# 7) Flatten a List of Lists

# In[15]:


nested_list = [[1,2,3],[4,5,6],[7,8,9]]

flat_list = [i for j in nested_list for i in j]

print(flat_list)

# Returns [1, 2, 3, 4, 5, 6, 7, 8, 9]


# 8) Check for Uniqueness

# In[16]:


list1 = [1,2,3,4,5]
list2 = [1,1,2,3,4]

def isunique(list):
    if len(list) == len(set(list)):
        print('Unique!')
    else: 
        print('Not Unique!')

isunique(list1)
isunique(list2)

# Returns 
# Unique!
# Not Unique!


# In[ ]:


get_ipython().system(' jupyter nbconvert --to script "8 Advanced Python Lists".ipynb')

