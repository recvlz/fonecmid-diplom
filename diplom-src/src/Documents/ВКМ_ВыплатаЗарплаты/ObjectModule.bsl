#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий   

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	
//Записать движения: ВКМ_ВзаиморасчетыССотрудниками
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записывать = Истина;
	Для Каждого ТекСтрокаВыплата Из Выплаты Цикл
		Движение = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Сотрудник = ТекСтрокаВыплата.Сотрудник;
		Движение.Сумма = ТекСтрокаВыплата.Сумма;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти 

#КонецЕсли