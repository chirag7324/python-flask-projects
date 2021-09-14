-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 14, 2021 at 11:33 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone_num` varchar(12) NOT NULL,
  `msg` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'test', '1234567890', 'abcdefghi', '2021-09-09 00:00:00', 'abctest@gmail.com'),
(2, 'chirag patel', '5712659691', 'hghkj', '2021-09-09 14:40:12', 'chiragpatel7324@gmail.com'),
(3, 'mera nam', '0987654321', 'kuch bhi add karo', '2021-09-09 21:45:23', 'meranam@gmail.com'),
(4, 'mera nam', '0987654321', 'kuch bhiu add karo', '2021-09-09 21:45:53', 'meranam@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(20) NOT NULL,
  `title` varchar(120) NOT NULL,
  `content` varchar(500) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `img_file` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `content`, `slug`, `img_file`, `date`) VALUES
(1, 'This is my first test post for edit.', 'i love to do this blog, because this is my first project in flask python', 'first-post', 'post-bg.jpg', '2021-09-12 12:52:57'),
(2, 'programming language', 'Computer programming is the process of designing and building an executable computer program to accomplish a specific computing result or to perform a specific task. Programming involves tasks such as: analysis, generating algorithms, profiling algorithms\' accuracy and resource consumption, and the implementation of algorithms in a chosen programming language (commonly referred to as coding).[1][2] The source code of a program is written in one or more languages that are intelligible to programm', 'programming', 'post-bg.jpg', '2021-09-12 11:40:02'),
(3, 'computer', 'Tasks accompanying and related to programming include: testing, debugging, source code maintenance, implementation of build systems, and management of derived artifacts, such as the machine code of computer programs. These might be considered part of the programming process, but often the term software development is used for this larger process with the term programming, implementation, or coding reserved for the actual writing of code. Software engineering combines engineering techniques with ', 'computer', 'post-bg.jpg', '2021-09-10 10:47:00'),
(4, 'flask language', 'We left the if block empty, now we will write code in it to verify the user. For that first we need to have correct username and password stored somewhere, in this case we have saved it in json file. We will access it through params. It would be like this:', 'flask', 'post-bg.jpg', '2021-09-12 15:07:26'),
(5, '10 Facts about Oceans |', 'khksdfibgkc', 'dgggg', 'bj.jpg', '2021-09-12 09:56:46'),
(6, 'sdkabkdsb', 'xcdvz', 'bcvx', 'bcv', '2021-09-12 11:03:10'),
(7, 'sdkabkdsb', 'xcdvz', 'bcvx', 'bcv', '2021-09-12 11:03:56'),
(8, 'sdkabkdsb', 'xcdsv', 'xdbgf', 'xfbdhgc', '2021-09-12 11:59:48'),
(9, '3', 'dsfvcsfbfbdgf', 'sdvbvfds', 'sdfvc', '2021-09-12 12:53:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
