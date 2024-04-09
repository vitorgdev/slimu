-- Atualizar as tabelas existentes para referenciar UUIDs do sistema de autenticação do Supabase
ALTER TABLE feedbacks
  DROP COLUMN reviewer_id,
  DROP COLUMN reviewed_id,
  ADD COLUMN reviewer_auth_id UUID NOT NULL,
  ADD COLUMN reviewed_auth_id UUID NOT NULL,
  ADD FOREIGN KEY (reviewer_auth_id) REFERENCES auth.users(id),
  ADD FOREIGN KEY (reviewed_auth_id) REFERENCES auth.users(id);


DROP TABLE IF EXISTS users;