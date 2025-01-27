
-- ALTER TABLE [Forum].[User]
--     ADD [email] VARCHAR(50) not null UNIQUE
-- GO

-- Create the schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Forum')
BEGIN
    EXEC('CREATE SCHEMA Forum');
END
GO

-- Create the User table
CREATE TABLE forum.[User] (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    [Password] NVARCHAR(64) NOT NULL
);
GO

-- Insert data into the User table
INSERT INTO Forum.[User] (UserName, Email, [Password])
VALUES
    ('john', 'johndoe@example.com', '9b60e907c21f2b678a56277d0a7b2f3e'),
    ('jane', 'janedoe@example.com', '5a7df7c3d62e8f8d6b0c52df1a9f4d3c'),
    ('dave', 'davesmith@example.com', '3e5f913cb45a1a389ff41b74a8d7e9fa'),
    ('sarah', 'sarahlee@example.com', 'd2c7a12fc8e6b3d7b6f9e5c73bdfda4e');
GO


-- Create the Profile table
CREATE TABLE Forum.[Profile] (
    ProfileId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Bio NVARCHAR(MAX) NOT NULL,
    UserId INT NOT NULL,
    Constraint FK_Profile_User FOREIGN KEY (UserId) REFERENCES Forum.[User] (UserId)
);
GO

-- Insert data into the Profile table
INSERT INTO Forum.[Profile] ( FirstName, LastName, Bio, UserId)
VALUES
    ('John', 'Doe', 'Web developer with a passion for open-source.', 1),
    ('Jane', 'Doe', 'UX designer focused on user-friendly interfaces.', 2),
    ('Dave', 'Smith', 'Full-stack developer and tech enthusiast.', 3),
    ('Sarah', 'Lee', 'Data scientist with a background in AI.', 4);
GO

-- Create the Category table
CREATE TABLE Forum.[Category] (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
GO

-- Insert data into the Category table
INSERT INTO Forum.[Category] ( Name)
VALUES
    ('Frontend Development'),
    ('Backend Development'),
    ('Full Stack Development');
GO

-- Create the Topic table
CREATE TABLE Forum.[Topic] (
    TopicId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    CategoryId INT NOT NULL,
    UserId INT NOT NULL,
    CONSTRAINT FK_Topic_Category FOREIGN KEY (CategoryId) REFERENCES Forum.[Category](CategoryId),
    CONSTRAINT FK_Topic_User FOREIGN KEY (UserId) REFERENCES Forum.[User](UserId)
);
GO

-- Insert data into the Topic table
INSERT INTO Forum.[Topic] (Title, Content, CategoryId, UserId)
VALUES
     ('Recommendations for Frontend Frameworks in 2024', 
     'I''m planning to start a new project and am a bit torn between which frontend framework to use in 2024. I''ve been using Vue.js for a while, but I''ve heard great things about React and Angular as well. I''d like something that scales well and has good community support, especially for handling complex state management and building reusable components. What do you guys recommend? Should I stick with Vue, or explore React/Angular for this project? Any other frameworks I should consider?', 
     1, 3);
GO

-- Create the Like table
CREATE TABLE Forum.[Like] (
    LikeId INT IDENTITY(1,1) PRIMARY KEY,
    TopicId INT NOT NULL,
    UserId INT NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT FK_Like_Topic FOREIGN KEY (TopicId) REFERENCES Forum.[Topic](TopicId),
    CONSTRAINT FK_Like_User FOREIGN KEY (UserId) REFERENCES Forum.[User](UserId)
);
GO

-- Insert data into the Like table
INSERT INTO Forum.[Like] (TopicId, UserId)
VALUES
    (1, 1),
    (1, 2),
    (1, 4);
GO



-- Create the Reply table
CREATE TABLE Forum.[Reply] (
    ReplyId INT IDENTITY(1,1) PRIMARY KEY,
    TopicId INT NOT NULL,
    UserId INT NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT FK_Reply_Topic FOREIGN KEY (TopicId) REFERENCES Forum.[Topic](TopicId),
    CONSTRAINT FK_Reply_User FOREIGN KEY (UserId) REFERENCES Forum.[User](UserId)
);
GO

-- Insert data into the Reply table
INSERT INTO Forum.[Reply] (TopicId, UserId, Content)
VALUES
    (1, 1, 'Vue is still a great choice, especially with the new Composition API making state management easier. But if you''re looking for flexibility and a large ecosystem, React is worth trying too.');
GO

-- Create the ReplyLike table
CREATE TABLE Forum.[ReplyLike] (
    RlId INT IDENTITY(1,1) PRIMARY KEY,
    ReplyId INT NOT NULL,
    UserId INT NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT FK_ReplyLike_Reply FOREIGN KEY (ReplyId) REFERENCES Forum.[Reply](ReplyId),
    CONSTRAINT FK_ReplyLike_User FOREIGN KEY (UserId) REFERENCES Forum.[User](UserId)
);
GO

-- Insert data into the ReplyLike table
INSERT INTO Forum.[ReplyLike] (ReplyId, UserId)
VALUES
    (1, 3),
    (1, 2);
GO