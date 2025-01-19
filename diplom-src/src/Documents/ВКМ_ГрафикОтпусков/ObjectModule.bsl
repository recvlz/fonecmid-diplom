#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий 

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ,Режим)
	
	// Движения по регистру ВКМ_ГрафикОтпусков
	Движения.ВКМ_ГрафикОтпусков.Записывать = Истина;
	Для Каждого ТекСтрокаОтпускаСотрудников Из ОтпускаСотрудников Цикл
	Движение = Движения.ВКМ_ГрафикОтпусков.Добавить();
	Движение.Сотрудник = ТекСтрокаОтпускаСотрудников.Сотрудник;
	Движение.ДатаНачала = ТекСтрокаОтпускаСотрудников.ДатаНачала;
	Движение.ДатаОкончания = ТекСтрокаОтпускаСотрудников.ДатаОкончания;
	Движение.Год = Год;
	КонецЦикла; 

КонецПроцедуры

#КонецОбласти

#КонецЕсли