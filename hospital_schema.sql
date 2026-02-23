CREATE TABLE medicos (
    id SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    especialidade_id INT NOT NULL,
    
    FOREIGN KEY (especialidade_id) 
    REFERENCES especialidades(id)
);

INSERT INTO especialidades (nome)
VALUES ('Cardiologia');

INSERT INTO medicos (nome_completo, telefone, especialidade_id)
VALUES ('Dr. João Silva', '48999990000', 1);

CREATE TABLE pacientes (
    id SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    genero VARCHAR(20),
    telefone VARCHAR(20),
    endereco TEXT
);

INSERT INTO pacientes 
(nome_completo, data_nascimento, genero, telefone, endereco)
VALUES 
('Diego Henrique Richertt', '1996-03-26', 'Masculino', '48999990000', 'Florianópolis - SC');

CREATE TABLE consultas (
    id SERIAL PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    data_consulta TIMESTAMP NOT NULL,
    observacoes TEXT,
    tipo_atendimento VARCHAR(50),

    FOREIGN KEY (paciente_id) 
    REFERENCES pacientes(id),

    FOREIGN KEY (medico_id) 
    REFERENCES medicos(id)
);

INSERT INTO consultas 
(paciente_id, medico_id, data_consulta, observacoes, tipo_atendimento)
VALUES 
(1, 1, '2026-02-23 16:00:00', 'Consulta de rotina', 'Particular');

CREATE TABLE tratamentos (
    id SERIAL PRIMARY KEY,
    consulta_id INT NOT NULL,
    medicamentos TEXT,
    descricao TEXT,

    FOREIGN KEY (consulta_id)
    REFERENCES consultas(id)
);

INSERT INTO tratamentos 
(consulta_id, medicamentos, descricao)
VALUES 
(1, 'Paracetamol 500mg', 'Tomar 1 comprimido a cada 8 horas por 5 dias');

SELECT
    pacientes.nome_completo AS nome_paciente,
    consultas.data_consulta,
    consultas.tipo_atendimento,
    medicos.nome_completo AS nome_medico
FROM pacientes
JOIN consultas 
    ON pacientes.id = consultas.paciente_id
JOIN medicos 
    ON consultas.medico_id = medicos.id;

SELECT
    medicos.nome_completo AS nome_medico,
    pacientes.nome_completo AS nome_paciente,
    consultas.data_consulta,
    consultas.observacoes,
    consultas.tipo_atendimento
FROM consultas
JOIN medicos
    ON consultas.medico_id = medicos.id
JOIN pacientes
    ON consultas.paciente_id = pacientes.id
WHERE medicos.nome_completo = 'Dr. João Silva';

SELECT
    pacientes.nome_completo AS nome_paciente,
    medicos.nome_completo AS nome_medico,
    consultas.data_consulta,
    tratamentos.medicamentos,
    tratamentos.descricao
FROM tratamentos
JOIN consultas
    ON tratamentos.consulta_id = consultas.id
JOIN pacientes
    ON consultas.paciente_id = pacientes.id
JOIN medicos
    ON consultas.medico_id = medicos.id;

SELECT
    medicos.nome_completo AS nome_medico,
    medicos.telefone,
    especialidades.nome AS especialidade
FROM medicos
JOIN especialidades
    ON medicos.especialidade_id = especialidades.id;

SELECT
    consultas.data_consulta,
    consultas.tipo_atendimento,
    pacientes.nome_completo AS nome_paciente,
    medicos.nome_completo AS nome_medico
FROM consultas
JOIN pacientes
    ON consultas.paciente_id = pacientes.id
JOIN medicos
    ON consultas.medico_id = medicos.id
WHERE DATE(consultas.data_consulta) = '2026-02-23';

SELECT DISTINCT
    pacientes.nome_completo AS nome_paciente,
    especialidades.nome AS especialidade_medica
FROM pacientes
JOIN consultas
    ON pacientes.id = consultas.paciente_id
JOIN medicos
    ON consultas.medico_id = medicos.id
JOIN especialidades
    ON medicos.especialidade_id = especialidades.id
WHERE especialidades.nome = 'Cardiologia';

SELECT
    pacientes.nome_completo AS nome_paciente,
    medicos.nome_completo AS nome_medico,
    consultas.data_consulta,
    tratamentos.medicamentos,
    tratamentos.descricao
FROM tratamentos
JOIN consultas
    ON tratamentos.consulta_id = consultas.id
JOIN pacientes
    ON consultas.paciente_id = pacientes.id
JOIN medicos
    ON consultas.medico_id = medicos.id
WHERE pacientes.nome_completo = 'Diego Henrique Richertt';

