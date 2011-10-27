-- Criado em: 20/02/2010
-- Autor: Fabricio P. Reis

use sop;

-- Inserts para os grupos de acesso
insert into GrupoAcesso values (1, 'Administrador', 'Grupo de usuarios com perfil de administrador do sistema');
insert into GrupoAcesso values (2, 'Administrador-TI', 'Grupo de usuarios com perfil de administrador de TI');
insert into GrupoAcesso values (3, 'Caixa', 'Grupo de usuarios com perfil de caixa');
insert into GrupoAcesso values (4, 'Dentista-Orcamento', 'Grupo de usuarios com perfil de Dentista-orcamento');
insert into GrupoAcesso values (5, 'Dentista-Tratamento', 'Grupo de usuarios com perfil de Dentista-tratamento');
insert into GrupoAcesso values (6, 'Financeiro', 'Grupo de usuarios com perfil de administrador financeiro');
insert into GrupoAcesso values (7, 'Relatorio', 'Grupo de usuarios com perfil de relatorio');
insert into GrupoAcesso values (8, 'Secretaria', 'Grupo de usuarios com perfil de secretaria');

-- Inserts para primeiro usuario
insert into Pessoa (id, nome, sexo, dataNascimento) values (1, 'Primeiro-Acesso', 'M', '2010-01-01');
insert into Funcionario values (1, 'fabricioreis', '1234',  '', 'Administrador de TI', 'A', '12345');
insert into FuncionarioGrupoAcesso values (1, 2);

-- Insere Dentista do sistema usado para criar objetos AtendimentoOrcamento, AtendimentoTratamento
insert into Pessoa (id, nome, sexo, dataNascimento) values (2, 'Dentista-Sistema', 'M', '2010-01-01');
insert into Funcionario values (2, 'Dentista-sistema', '12345678', '', 'Dentista-Sistema', 'A', '12345');
insert into Dentista values (2, null, null, default, default);

-- Inserts para primeiro Paciente usado para criar Ficha para criar AtendimentoTratamento e AtendimentoOrcamento
insert into Pessoa (id, nome, sexo, dataNascimento) values (3, 'Paciente-Sistema', 'M', '2010-01-01');
insert into Paciente values (3, 'Paciente-Sistema', null, 'I', default, default);

-- Inserts para primeira Ficha usados para criar AtendimentoTratamento e AtendimentoOrcamento
insert into Ficha values (1, 3, '2010-01-01', null, null, default);

-- Inserts para status de procedimento
insert into StatusProcedimento values (1, 1, 'Orçado', 'Procedimento orçado. Dente a ser tratado. Pagamento pendente.'); 
insert into StatusProcedimento values (2, 2, 'Liberado/Pago', 'Procedimento pago. Dente liberado para tratamento.'); 
insert into StatusProcedimento values (3, 3, 'Em tratamento', 'Procedimento em execução. Dente em tratamento.'); 
insert into StatusProcedimento values (4, 4, 'Finalizado', 'Procedimento finalizado. Dente tratado e / ou não possui pendências.');

-- Inserts para status de cheque bancario
insert into StatusChequeBancario values (1, 1, 'Não Depositado', 'Cheque não depositado.'); 
insert into StatusChequeBancario values (2, 2, 'Aguardando Confirmação de Crédito', 'Cheque depositado e aguardando confirmação de compensação.'); 
insert into StatusChequeBancario values (3, 3, 'Irregular', 'Cheque irregular. Cheque não compensado.'); 
insert into StatusChequeBancario values (4, 4, 'Compensado', 'Cheque depositado e compensado com sucesso.');
insert into StatusChequeBancario values (5, 5, 'Cancelado', 'Cheque cancelado. Devolvido para o cliente.');

-- Inserts para as fila de atendimento
insert into FilaAtendimentoOrcamento values (1, 'Fila de atendimento de orcamentos'); 
insert into FilaAtendimentoTratamento values (1, 'Fila de atendimento de tratamentos');
insert into FilaAtendimentoOrcamento values (2, 'Fila de atendimento de orcamentos em atendimento'); 
insert into FilaAtendimentoTratamento values (2, 'Fila de atendimento de tratamentos em atendimento');
insert into FilaAtendimentoOrcamento values (3, 'Fila de atendimento de orcamentos finalizados'); 
insert into FilaAtendimentoTratamento values (3, 'Fila de atendimento de tratamentos finalizados');

-- Insert para os atendimentos Orcamento e Tratamento
insert into AtendimentoOrcamento values (1, '2010-01-01', '2010-01-01', '2010-01-01', 1, 2, default, 2, default);
insert into AtendimentoTratamento values (1, '2010-01-01', '2010-01-01', '2010-01-01', 1, 2, default, 2, default);


-- Apos criar um usuario pelo sistema, deve-se apagar os registros do primeiro acesso
-- Inserts para primeiro usuario
delete from FuncionarioGrupoAcesso where funcionarioId = 1;
delete from Funcionario where id = 1;
delete from Pessoa where id = 1;