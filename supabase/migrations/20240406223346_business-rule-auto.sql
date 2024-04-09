-- Modificar a tabela feedback para adicionar campo de texto aberto
ALTER TABLE feedbacks
ADD COLUMN open_text_feedback TEXT;

-- Criação da tabela BUConfig para armazenar configurações globais da BU
CREATE TABLE bu_config (
  id SERIAL PRIMARY KEY,
  business_unit_id INTEGER NOT NULL,
  max_evaluators INTEGER NOT NULL,
  min_evaluators INTEGER NOT NULL,
  FOREIGN KEY (business_unit_id) REFERENCES business_units(id)
);

-- Criação da tabela EvaluatorSelection para gerenciar a seleção de avaliadores
CREATE TABLE evaluator_selection (
  id SERIAL PRIMARY KEY,
  user_auth_id UUID NOT NULL,
  evaluator_auth_id UUID NOT NULL,
  status VARCHAR(255) NOT NULL, -- 'pending', 'approved', 'rejected'
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  approved_at TIMESTAMP WITH TIME ZONE,
  FOREIGN KEY (user_auth_id) REFERENCES auth.users(id),
  FOREIGN KEY (evaluator_auth_id) REFERENCES auth.users(id)
);

-- Habilita RLS para EvaluatorSelection
ALTER TABLE evaluator_selection ENABLE ROW LEVEL SECURITY;

-- Define as políticas de RLS para EvaluatorSelection
CREATE POLICY "Usuários podem ver suas seleções de avaliadores" ON evaluator_selection
  FOR SELECT USING (auth.uid() = user_auth_id);

CREATE POLICY "Usuários podem criar seleções de avaliadores" ON evaluator_selection
  FOR INSERT WITH CHECK (auth.uid() = user_auth_id);

CREATE POLICY "Líderes podem aprovar seleções de avaliadores" ON evaluator_selection
  FOR UPDATE USING (auth.uid() = evaluator_auth_id);