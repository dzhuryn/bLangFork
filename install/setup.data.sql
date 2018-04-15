-- phpMyAdmin SQL Dump
-- version 4.7.8
-- https://www.phpmyadmin.net/

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `dmi3yy4_site15`
--

-- --------------------------------------------------------

--
-- Структура таблицы `{PREFIX}blang`
--

CREATE TABLE `{PREFIX}blang` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `title` varchar(255) NOT NULL,
  `ru` varchar(255) NOT NULL,
  `ua` varchar(255) NOT NULL,
  `en` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `{PREFIX}blang_settings`
--

CREATE TABLE `{PREFIX}blang_settings` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Contains Content Manager settings.';

--
-- Дамп данных таблицы `{PREFIX}blang_settings`
--

INSERT INTO `{PREFIX}blang_settings` (`name`, `value`) VALUES
('langs', 'ua,ru,en'),
('root', 'ua'),
('fields', '1'),
('translate', '1'),
('yandexKey', 'trnsl.1.1.20171018T194048Z.17a3ca94fa417e68.fe36a809edc91525752124301b3d7ca3533dc9cd');

-- --------------------------------------------------------

--
-- Структура таблицы `{PREFIX}blang_tmplvars`
--

CREATE TABLE `{PREFIX}blang_tmplvars` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `tab` varchar(255) NOT NULL,
  `caption` varchar(80) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `editor_type` int(11) NOT NULL DEFAULT '0' COMMENT '0-plain text,1-rich text,2-code editor',
  `category` int(11) NOT NULL DEFAULT '0' COMMENT 'category id',
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `elements` text,
  `rank` int(11) NOT NULL DEFAULT '0',
  `display` varchar(20) NOT NULL DEFAULT '' COMMENT 'Display Control',
  `display_params` text COMMENT 'Display Control Properties',
  `default_text` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Site Template Variables';

-- --------------------------------------------------------

--
-- Структура таблицы `{PREFIX}blang_tmplvar_access`
--

CREATE TABLE `{PREFIX}blang_tmplvar_access` (
  `id` int(10) NOT NULL,
  `tmplvarid` int(10) NOT NULL DEFAULT '0',
  `documentgroup` int(10) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Contains data used for template variable access permissions.';

-- --------------------------------------------------------

--
-- Структура таблицы `{PREFIX}blang_tmplvar_templates`
--

CREATE TABLE `{PREFIX}blang_tmplvar_templates` (
  `tmplvarid` int(10) NOT NULL DEFAULT '0' COMMENT 'Template Variable id',
  `templateid` int(11) NOT NULL DEFAULT '0',
  `rank` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Site Template Variables Templates Link Table';

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `{PREFIX}blang`
--
ALTER TABLE `{PREFIX}blang`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `{PREFIX}blang_settings`
--
ALTER TABLE `{PREFIX}blang_settings`
  ADD PRIMARY KEY (`name`);

--
-- Индексы таблицы `{PREFIX}blang_tmplvars`
--
ALTER TABLE `{PREFIX}blang_tmplvars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `indx_rank` (`rank`);

--
-- Индексы таблицы `{PREFIX}blang_tmplvar_access`
--
ALTER TABLE `{PREFIX}blang_tmplvar_access`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `{PREFIX}blang_tmplvar_templates`
--
ALTER TABLE `{PREFIX}blang_tmplvar_templates`
  ADD PRIMARY KEY (`tmplvarid`,`templateid`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `{PREFIX}blang`
--
ALTER TABLE `{PREFIX}blang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT для таблицы `{PREFIX}blang_tmplvars`
--
ALTER TABLE `{PREFIX}blang_tmplvars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT для таблицы `{PREFIX}blang_tmplvar_access`
--
ALTER TABLE `{PREFIX}blang_tmplvar_access`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
