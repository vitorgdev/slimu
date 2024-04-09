-- Cria a tabela business_unit
CREATE TABLE business_units (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  document VARCHAR(255) UNIQUE,
  address TEXT,
  phone VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  website VARCHAR(255),
  logo_url VARCHAR(255),
  responsible_name VARCHAR(255),
  responsible_contact VARCHAR(255),
  stripe_customer_id VARCHAR(255),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Cria a tabela department
CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  business_unit_id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (business_unit_id) REFERENCES business_units(id)
);

-- Cria a tabela role
CREATE TABLE roles (
  id SERIAL PRIMARY KEY,
  department_id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Cria a tabela level
CREATE TABLE levels (
  id SERIAL PRIMARY KEY,
  role_id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Cria a tabela macro_skill
CREATE TABLE macro_skills (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT
);

-- Cria a tabela child_skill
CREATE TABLE child_skills (
  id SERIAL PRIMARY KEY,
  macro_skill_id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  level_required INTEGER,
  FOREIGN KEY (macro_skill_id) REFERENCES macro_skills(id)
);

-- Cria a tabela user
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  business_unit_id INTEGER NOT NULL,
  department_id INTEGER NOT NULL,
  role_id INTEGER NOT NULL,
  level_id INTEGER,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  manager_id INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (business_unit_id) REFERENCES business_units(id),
  FOREIGN KEY (department_id) REFERENCES departments(id),
  FOREIGN KEY (role_id) REFERENCES roles(id),
  FOREIGN KEY (level_id) REFERENCES levels(id),
  FOREIGN KEY (manager_id) REFERENCES users(id)
);

-- Cria a tabela evaluation
CREATE TABLE evaluations (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  start_date TIMESTAMP WITH TIME ZONE,
  end_date TIMESTAMP WITH TIME ZONE,
  status VARCHAR(255) NOT NULL
);

-- Cria a tabela feedback
CREATE TABLE feedbacks (
  id SERIAL PRIMARY KEY,
  evaluation_id INTEGER NOT NULL,
  reviewer_id INTEGER NOT NULL,
  reviewed_id INTEGER NOT NULL,
  timestamp TIMESTAMP WITH TIME ZONE,
  FOREIGN KEY (evaluation_id) REFERENCES evaluations(id),
  FOREIGN KEY (reviewer_id) REFERENCES users(id),
  FOREIGN KEY (reviewed_id) REFERENCES users(id)
);

-- Cria a tabela feedback_skills
CREATE TABLE feedback_skills (
  feedback_id INTEGER NOT NULL,
  child_skill_id INTEGER NOT NULL,
  score INTEGER,
  FOREIGN KEY (feedback_id) REFERENCES feedbacks(id),
  FOREIGN KEY (child_skill_id) REFERENCES child_skills(id)
);

-- Cria a tabela pricing_plan
CREATE TABLE pricing_plans (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  monthly_price DECIMAL,
  features TEXT,
  stripe_plan_id VARCHAR(255),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Cria a tabela bu_subscriptions
CREATE TABLE bu_subscriptions (
  id SERIAL PRIMARY KEY,
  business_unit_id INTEGER NOT NULL,
  pricing_plan_id INTEGER NOT NULL,
  stripe_subscription_id VARCHAR(255),
  start_date TIMESTAMP WITH TIME ZONE,
  end_date TIMESTAMP WITH TIME ZONE,
  status VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (business_unit_id) REFERENCES business_units(id),
  FOREIGN KEY (pricing_plan_id) REFERENCES pricing_plans(id)
);


-- Habilita RLS para business_units
ALTER TABLE business_units ENABLE ROW LEVEL SECURITY;

-- Trigger automático para atualização do campo updated_at
CREATE OR REPLACE FUNCTION public.set_current_timestamp_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_business_unit_updated_at BEFORE UPDATE ON business_units
  FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
