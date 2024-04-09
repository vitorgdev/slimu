CREATE TABLE audit_logs (
  id SERIAL PRIMARY KEY,
  user_auth_id UUID,
  action VARCHAR(255) NOT NULL,
  entity_name VARCHAR(255) NOT NULL,
  entity_id UUID NOT NULL,
  details JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_auth_id) REFERENCES auth.users(id)
);
