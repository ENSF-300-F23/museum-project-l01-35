import mysql.connector
from tkinter import Tk, Label, Button, Entry, messagebox

# Function to connect to the database
def connect_to_database():
    return mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="password",
        database="art_gallery"
    )

# Function to authenticate users

def authenticate_user(username, password):
    try:
        db_connection = connect_to_database()
        cursor = db_connection.cursor()

        query = "SELECT * FROM users WHERE username = %s AND password = %s"
        cursor.execute(query, (username, password))
        user_record = cursor.fetchone()

        db_connection.close()

        if user_record:
            return True
        else:
            return False
    except mysql.connector.Error as err:
        print("Error:", err)
        return False         




# Admin functionality
def admin_interface():
    print("Admin Interface")
    print('1 - Modify tables')
    print('2 - Add users')
    print('3 - Block users')
    choice = input("Enter your choice: ")

    db_connection = connect_to_database()
    cursor = db_connection.cursor()

    if choice == '1':
        # Logic to modify tables, alter schema, etc.
        pass
    elif choice == '2':
        new_username = input("Enter new user's username: ")
        new_password = input("Enter new user's password: ")
        # Logic to add new users to the database
        cursor.execute("CREATE USER %s@localhost IDENTIFIED BY %s", (new_username, new_password))
        cursor.execute("GRANT SELECT, INSERT, UPDATE, DELETE ON art_gallery.* TO %s@localhost", (new_username,))
        db_connection.commit()
        print("User added successfully.")
    elif choice == '3':
        username_to_block = input("Enter username to block: ")
        # Logic to block a user
        cursor.execute("DROP USER %s@localhost", (username_to_block,))
        db_connection.commit()
        print("User blocked successfully.")
    else:
        print("Invalid choice")

    db_connection.close()
# Employee functionality
def employee_interface():
    print("Employee Interface")
    print('1 - Add new art object')
    print('2 - Update existing art object')
    print('3 - Remove art object')
    choice = input("Enter your choice: ")

    db_connection = connect_to_database()
    cursor = db_connection.cursor()

    if choice == '1':
        name = input("Enter object name: ")
        category = input("Enter category (painting/sculpture/other): ")
        exhibition_id = input("Enter exhibition ID: ")
        cursor.execute("INSERT INTO ArtObjects (object_name, category, exhibition_id) VALUES (%s, %s, %s)",
                       (name, category, exhibition_id))
        db_connection.commit()
        print("New art object added successfully.")
    elif choice == '2':
        object_id = input("Enter object ID to update: ")
        new_name = input("Enter new object name: ")
        new_category = input("Enter new category: ")
        new_exhibition_id = input("Enter new exhibition ID: ")
        cursor.execute("UPDATE ArtObjects SET object_name = %s, category = %s, exhibition_id = %s WHERE object_id = %s",
                       (new_name, new_category, new_exhibition_id, object_id))
        db_connection.commit()
        print("Art object updated successfully.")
    elif choice == '3':
        object_id = input("Enter object ID to remove: ")
        cursor.execute("DELETE FROM ArtObjects WHERE object_id = %s", (object_id,))
        db_connection.commit()
        print("Art object removed successfully.")
    else:
        print("Invalid choice")

    db_connection.close()

# Guest functionality
def guest_interface():
    print('What are you looking for?')
    print('1 - Show all paintings')
    print('2 - Show all sculptures')
    print('3 - Show other items')
    choice = input("Enter your choice: ")

    db_connection = connect_to_database()
    cursor = db_connection.cursor()

    if choice == '1':
        cursor.execute("SELECT * FROM ArtObjects WHERE category='painting'")
    elif choice == '2':
        cursor.execute("SELECT * FROM ArtObjects WHERE category='sculpture'")
    elif choice == '3':
        cursor.execute("SELECT * FROM ArtObjects WHERE category='other'")
    else:
        print("Invalid choice")

    items = cursor.fetchall()
    for item in items:
        print(item)  # Displaying the retrieved items

    db_connection.close()

# GUI setup using Tkinter for different user roles
def setup_gui(user_role):
    root = Tk()
    root.title("Art Gallery App")

    if user_role == "Admin":
        admin_interface()
    elif user_role == "Employee":
        employee_interface()
    else:
        guest_interface()

    root.mainloop()

# Function to handle login button click
def handle_login():
    username = username_entry.get()
    password = password_entry.get()

    if authenticate_user(username, password):
        messagebox.showinfo("Success", "Login Successful!")
        # Implement logic to determine user role based on authentication
        user_role = "Admin"  
        setup_gui(user_role)
    else:
        messagebox.showerror("Error", "Invalid Credentials")

# GUI setup for login
def setup_login_gui():
    root = Tk()
    root.title("Login")

    # Username Label and Entry
    username_label = Label(root, text="Username:")
    username_label.pack()
    global username_entry
    username_entry = Entry(root)
    username_entry.pack()

    # Password Label and Entry
    password_label = Label(root, text="Password:")
    password_label.pack()
    global password_entry
    password_entry = Entry(root, show="*")
    password_entry.pack()

    # Login Button
    login_button = Button(root, text="Login", command=handle_login)
    login_button.pack()

    root.mainloop()

# Main function to run the login GUI
def main():
    setup_login_gui()

if __name__ == "__main__":
    main()
