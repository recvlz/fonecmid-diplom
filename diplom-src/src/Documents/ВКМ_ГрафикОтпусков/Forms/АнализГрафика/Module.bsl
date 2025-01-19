#Область ОбработчикиСобытийФормы 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ОтпускаСотрудников = ПолучитьИзВременногоХранилища(Параметры.Адрес);
	
	Для Каждого Строка Из ОтпускаСотрудников Цикл  
		
		Точка = Диаграмма.УстановитьТочку(Строка.Сотрудник);
		Серия = Диаграмма.УстановитьСерию("Отпуск");
		
		Значение = Диаграмма.ПолучитьЗначение(Точка, Серия);
		
		Интервал = Значение.Добавить();
		Интервал.Начало = Строка.ДатаНачала;
		Интервал.Конец = Строка.ДатаОкончания;	
		
	КонецЦикла; 

КонецПроцедуры

#КонецОбласти
