﻿#language: ru

@tree

Функционал: Использование обработки "Массовое создание актов"

Как тестировщик я хочу проверить формирование отчета "Анализ выставленных актов" от имени пользователя с ролью "Бухгалтер ИТ-фирмы"
чтобы проверить работу нового функционала и убедиться в правильности распределения ролей между пользователями.   

Контекст:
	Дано Я подключаю TestClient "Этот клиент" логин "Волкова (Бухгалтер)" пароль ""

Сценарий: Как пользователь с ролью Бухгалтер ИТ-фирмы формирую отчет "Анализ выставленных актов"

*Открыте отчета "Анализ выставленных актов"
	И В командном интерфейсе я выбираю 'Обслуживание клиентов (подсистема)' 'Анализ выставленных актов (отчет)'
	Тогда открылось окно 'Основной'
	И я нажимаю кнопку выбора у поля с именем "Период1ДатаНачала"
	И в поле с именем 'Период1ДатаНачала' я ввожу текст '01.01.2025'
	И я нажимаю кнопку выбора у поля с именем "Период1ДатаОкончания"
	И в поле с именем 'Период1ДатаОкончания' я ввожу текст '31.01.2025'
	И я нажимаю на кнопку с именем 'СформироватьОтчет'

	Тогда табличный документ "ОтчетТабличныйДокумент" содержит строки по шаблону
		| 'Анализ выставленных актов' | ''          | ''                        | ''                                  | ''                       | ''                                 |
		| ''                          | ''          | ''                        | ''                                  | ''                       | ''                                 |
		| 'Клиент'                    | 'Договор'   | 'Абонплата (должно быть)' | 'Работа специалистов (должно быть)' | 'Абонплата (выставлено)' | 'Работа специалистов (выставлено)' |
		| '*"'                        | 'Договор *' | '*'                       | '*'                                 | '*'                      | '*'                                |

*Закрытие клиента тестирования
	И я закрываю TestClient "Этот клиент"