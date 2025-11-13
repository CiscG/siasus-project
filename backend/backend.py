import pandas as pd
from sqlalchemy import create_engine

# Configuração do banco
db_user = 'root'
db_pass = 'bancosqltrabalho'
db_host = 'localhost'
db_name = 'francisco_siasus_schema'

# Conexão
connection_string = f"mysql+pymysql://{db_user}:{db_pass}@{db_host}/{db_name}"
engine = create_engine(connection_string)

# Lista de tabelas
tabelas = ['cadgerrs', 'cbo', 'cid10', 'micro', 'municipio', 'pars', 'procedimento', 'rl']
dataframes = {}

# Carregamento
try:
    for t in tabelas:
        query = f"SELECT * FROM {t}"
        dataframes[t] = pd.read_sql(query, engine)
        print(f"Tabela {t} carregada.")
except Exception as e:
    print(f"Erro: {e}")

# Definição dos DataFrames principais para uso fácil
df_pars = dataframes.get('pars')
df_proc = dataframes.get('procedimento')
df_cid = dataframes.get('cid10')
df_mun = dataframes.get('municipio')
df_cbo = dataframes.get('cbo')

