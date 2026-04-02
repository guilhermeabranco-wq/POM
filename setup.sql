-- Run this in your Supabase SQL Editor (https://supabase.com/dashboard/project/hwxfrfehgtcggueugakd/sql)

-- Create the selections table
CREATE TABLE IF NOT EXISTS pom_selections (
    id SERIAL PRIMARY KEY,
    section TEXT NOT NULL CHECK (section IN ('E8', 'E9')),
    group_name TEXT NOT NULL,
    cell_id TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(section, group_name)
);

-- Enable Row Level Security but allow all operations (public site)
ALTER TABLE pom_selections ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist, then recreate
DROP POLICY IF EXISTS "Allow public read" ON pom_selections;
CREATE POLICY "Allow public read" ON pom_selections
    FOR SELECT USING (true);

DROP POLICY IF EXISTS "Allow public insert" ON pom_selections;
CREATE POLICY "Allow public insert" ON pom_selections
    FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public update" ON pom_selections;
CREATE POLICY "Allow public update" ON pom_selections
    FOR UPDATE USING (true);

DROP POLICY IF EXISTS "Allow public delete" ON pom_selections;
CREATE POLICY "Allow public delete" ON pom_selections
    FOR DELETE USING (true);

-- Enable realtime for this table (ignore error if already added)
DO $$
BEGIN
    ALTER PUBLICATION supabase_realtime ADD TABLE pom_selections;
EXCEPTION WHEN duplicate_object THEN
    NULL;
END $$;
