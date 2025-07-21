# Museum Management Application

A role‑based museum management system featuring a Python/Tkinter GUI front‑end and a MySQL back‑end.  
Supports secure user authentication, CRUD operations on art objects and exhibitions, and rich data persistence.

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Features](#features)  
3. [Skills & Technologies](#skills--technologies)  
4. [Architecture & Organization](#architecture--organization)  
5. [Getting Started](#getting-started)  
   1. [Prerequisites](#prerequisites)  
   2. [Setup & Installation](#setup--installation)  
   3. [Running the Application](#running-the-application)  
6. [Usage & Roles](#usage--roles)  
7. [Future Enhancements](#future-enhancements)  
8. [Contributors & Responsibilities](#contributors--responsibilities)  

---

## Project Overview

This application enables museum staff and visitors to interact with an art gallery database through a user‑friendly GUI. It enforces **role-based access control**—Admins can manage users and database schema, Employees can perform CRUD on art objects, and Guests can browse and query exhibits. All data is stored in a MySQL database with referential integrity and meaningful sample data.  

---

## Features

- **User Authentication** with secure credential verification against the `users` table.  
- **Admin Interface**  
  - Create/drop database users and roles  
  - Modify database schema (e.g., add tables, alter columns)  
- **Employee Interface**  
  - Add, update, and delete Art Objects  
  - Maintain Exhibitions and Collections  
- **Guest Interface**  
  - Browse paintings, sculptures, and other items  
  - Execute filtered queries for quick lookups  
- **Database Scripts**  
  - Schema creation and sample data insertion  
  - Roles & permissions setup  
  - Query examples demonstrating nested, ordered, and joined operations  

---

## Skills & Technologies

- **Python & Object‑Oriented Design** (classes, functions, modular code) :contentReference[oaicite:0]{index=0}  
- **Tkinter GUI Development** (event‑driven programming, input validation) :contentReference[oaicite:1]{index=1}  
- **Relational Database Design** (ER modeling, foreign keys, cascading deletes) :contentReference[oaicite:2]{index=2}  
- **SQL & MySQL Administration** (DDL, DML, user/role management, triggers) :contentReference[oaicite:3]{index=3}  
- **Version Control with Git & GitHub** (branching, collaboration via GitHub Classroom)  
- **Error Handling & Logging** (exception management for robust connections)  
- **Team Collaboration** (task delegation, code reviews, shared documentation)  

---

## Architecture & Organization

