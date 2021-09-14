from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://root:@localhost/budget')
(engine.connect())
with engine.connect() as connection:
    result = connection.execute("select b_account from bank_accounts")
    for row in result:
        print("b_acoount:", row['b_account'])