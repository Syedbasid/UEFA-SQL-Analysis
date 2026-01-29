# UEFA SQL Analysis Project

## 📌 Project Overview
This project focuses on analyzing UEFA football competition data using **PostgreSQL**.  
The objective is to extract meaningful insights related to **goals, players, teams, matches, and stadiums** by writing efficient and well structured SQL queries.

The project demonstrates real-world SQL skills such as:
- multi table joins
- aggregations
- window functions
- handling missing data
- analytical problem solving

---

## 📊 Dataset Description
The analysis is based on five tables:

- **goals** – goal events including scorer, assist, and minute
- **matches** – match details such as teams, scores, season, and attendance
- **players** – player demographics and attributes
- **teams** – team information and home stadiums
- **stadiums** – stadium location and capacity details

---

## 🛠 Tools & Technologies Used
- PostgreSQL
- pgAdmin
- SQL
- Git & GitHub

---

## 🔍 Key Analysis Performed

### Goal Analysis
- top goal scorers per season
- goals per player and per match
- assist leaders per season
- goals scored in high attendance matches

### Match Analysis
- highest scoring matches
- home vs away wins
- draw analysis
- penalty shootout statistics
- attendance trends

### Player Analysis
- goals and assists contribution
- goals per match ratio
- age, height, and weight analysis
- performance by position
- country wise top performers

### Team Analysis
- teams with most goals (home + away)
- teams with most home wins
- team participation by country and season
- home stadium capacity comparison

### Stadium Analysis
- stadiums with highest capacity
- match hosting frequency
- attendance based performance analysis
- score difference analysis by stadium

### Complex & Cross-Table Analysis
- player performance in large stadiums
- goals scored in high-pressure matches
- assists in losing matches
- defender goal contributions
- advanced window function usage

---

## ⚠️ Assumptions & Limitations
- The dataset does **not contain a player appearance table**
- Player participation in matches is **inferred from the goals table**
- Records with **null player IDs** are excluded from player-based analysis
- These assumptions are clearly documented in the SQL files

---

## 📸 Sample Results
Screenshots of selected query results are included in the `Screenshots/` folder to visually demonstrate query outputs and correctness.

---

## 🚀 How to Run This Project
1. Create a PostgreSQL database
2. Run `schema/create_tables.sql` to create tables
3. Import CSV files using pgAdmin
4. Execute SQL files from the `sql_queries/` folder
5. View results in pgAdmin or screenshots folder

---

## 🎯 Learning Outcomes
- strong understanding of relational database design
- hands on experience with analytical SQL
- handling real world data quality issues
- writing clean, readable, and optimized queries
- structuring and documenting a data project for GitHub

---

## 👤 Author
**Syed Basid S**

---

## 📬 Contact
Feel free to connect with me on GitHub or LinkedIn for feedback.


