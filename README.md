🏥 Sistema Hospitalar — Banco de Dados SQL

Projeto de modelagem de banco de dados relacional desenvolvido em PostgreSQL para simular o controle de pacientes, médicos e consultas em um sistema hospitalar.


📌 Estrutura do Banco

O sistema é composto por 5 tabelas principais:

pacientes

medicos

especialidades

consultas

tratamentos


🔗 Relacionamentos

Uma especialidade pode ter vários médicos

Um paciente pode realizar várias consultas

Um médico pode atender vários pacientes

Uma consulta pode possuir múltiplos tratamentos


🧠 Conceitos Aplicados

Modelagem relacional

Chaves primárias e estrangeiras

Integridade referencial

Relacionamentos 1:N e N:N

Consultas SQL com JOIN


🔎 Consultas Implementadas

Pacientes com seus médicos e consultas

Consultas por médico

Tratamentos com dados de pacientes e médicos

Médicos com suas especialidades

Consultas por data

Pacientes atendidos por especialidade

Tratamentos vinculados a pacientes


🎯 Objetivo

Projeto desenvolvido para prática de SQL e modelagem de banco de dados como parte da preparação para atuação na área de tecnologia.
