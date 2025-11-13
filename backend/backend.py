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

print(f"Dimensões tabela PARS: {df_pars.shape}")
print(df_pars.dtypes)
print(df_pars[['pa_qtdpro', 'pa_valpro']].describe())
print(df_pars.isnull().sum())
print(df_pars[df_pars['pa_qtdpro'] < 0])

df_pars['pa_cidpri'] = df_pars['pa_cidpri'].fillna('NAO_INF')
df_pars = df_pars.drop_duplicates()
df_pars = df_pars[df_pars['pa_qtdpro'] >= 0]

df_completo = pd.merge(df_pars, df_proc, on='pa_proc_id', how='left')
print(df_completo['descricao'].value_counts().head(10))

ranking_estab = df_pars.groupby('pa_coduni')['pa_qtdpro'].sum().sort_values(ascending=False)
print(ranking_estab.head())

comparativo = df_pars[['pa_qtdpro', 'pa_qtdapr']].sum()
print(comparativo)

df_doencas = pd.merge(df_pars, df_cid, on='pa_cidpri', how='left')
print(df_doencas['descricao'].value_counts().head(5))

df_fluxo = pd.merge(df_pars, df_mun, left_on='pa_ufmun', right_on='cod_municipio', how='left')
print(df_fluxo['nome'].value_counts().head())

total_aprovado = df_pars['pa_valapr'].sum()
total_produzido = df_pars['pa_valpro'].sum()
diferenca = total_produzido - total_aprovado

print(f"Total Produzido: R$ {total_produzido:.2f}")
print(f"Total Aprovado: R$ {total_aprovado:.2f}")
print(f"Déficit/Superávit: R$ {diferenca:.2f}")
print(f"Valor médio por procedimento: R$ {df_pars['pa_valpro'].mean():.2f}")

onco = df_completo[df_completo['descricao'].str.contains('QUIMIOTERAPIA', na=False)]
print(f"Total procedimentos Oncologia: {onco['pa_qtdpro'].sum()}")

mental = df_completo[df_completo['descricao'].str.contains('PSICOTERAPIA|PSIQUIATRIA', regex=True, na=False)]
print(f"Total Saúde Mental: {mental['pa_qtdpro'].sum()}")

cidades_interesse = ['SANTA ROSA', 'IJUI', 'SANTO ANGELO']
comparacao = df_fluxo[df_fluxo['nome'].isin(cidades_interesse)]
print(comparacao.groupby('nome')['pa_qtdpro'].sum())
