import pandas as pd
from sqlalchemy import create_engine, text

EXCEL_FILE = r"C:\ExcelR\Project\Banking Project\Banking Project\Cleaned Data\Credit_Debit_Data.xlsx"

engine = create_engine(
    "postgresql+psycopg2://",
    connect_args={
        "host": "localhost",
        "port": 5432,
        "dbname": "project2",       # ← your actual database name in pgAdmin
        "user": "postgres",
        "password": "Sanskar@549sandy"
    }
)

# Test connection first
try:
    with engine.connect() as conn:
        conn.execute(text("SELECT 1"))
    print("✅ Connected to PostgreSQL!\n")
except Exception as e:
    print(f"❌ Connection failed: {e}")
    exit()

# Import sheets
xl = pd.ExcelFile(EXCEL_FILE)
SKIP_SHEETS = ["Sheet1"]

for sheet_name in xl.sheet_names:
    if sheet_name in SKIP_SHEETS:
        print(f"⏭  Skipping '{sheet_name}'")
        continue
    table_name = sheet_name.strip().lower()
    df = pd.read_excel(xl, sheet_name=sheet_name)
    df.to_sql(table_name, engine, if_exists="replace", index=False)
    print(f"✓  '{sheet_name}' → '{table_name}' ({len(df)} rows)")

print("\nAll done!")