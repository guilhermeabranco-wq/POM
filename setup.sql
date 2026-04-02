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

-- Allow anyone to read
CREATE POLICY "Allow public read" ON pom_selections
    FOR SELECT USING (true);

-- Allow anyone to insert
CREATE POLICY "Allow public insert" ON pom_selections
    FOR INSERT WITH CHECK (true);

-- Allow anyone to update
CREATE POLICY "Allow public update" ON pom_selections
    FOR UPDATE USING (true);

-- Allow anyone to delete
CREATE POLICY "Allow public delete" ON pom_selections
    FOR DELETE USING (true);

-- Enable realtime for this table
ALTER PUBLICATION supabase_realtime ADD TABLE pom_selections;
