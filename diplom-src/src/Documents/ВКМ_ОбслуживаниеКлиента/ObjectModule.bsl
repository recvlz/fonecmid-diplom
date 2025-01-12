#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
#Область ОбработчикиСобытий 

Процедура ОбработкаПроведения(Отказ,Режим)
	ДанныеДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Договор, "ВКМ_ДатаНачалаДействияДоговора, ВКМ_ДатаОкончанияДействияДоговора, ВидДоговора, ВКМ_СтоимостьЧасаРаботыСпециалиста");
	Если Не ДанныеДоговора.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
		ОбщегоНазначения.СообщитьПользователю("Выбранный договор не является договором на абонентское ослуживание.");
		Отказ = Истина;
	КонецЕсли;
	Если Дата < ДанныеДоговора.ВКМ_ДатаНачалаДействияДоговора ИЛИ Дата > ДанныеДоговора.ВКМ_ДатаОкончанияДействияДоговора Тогда
		ОбщегоНазначения.СообщитьПользователю("Непорядок со сроком действия договора.");
		Отказ = Истина;
	КонецЕсли;
	Движения.ВКМ_ВыполненныеКлиентуРаботы.Записывать = Истина;
	Движение = Движения.ВКМ_ВыполненныеКлиентуРаботы.Добавить();
	Движение.Период = Дата;
	Движение.Клиент = Клиент;
	Движение.Договор = Договор;
	Движение.КоличествоЧасов = ВыполненныеРаботы.Итог("ЧасыКОплатеКлиенту");
	Движение.СуммаКОплате = Движение.КоличествоЧасов * ДанныеДоговора.ВКМ_СтоимостьЧасаРаботыСпециалиста;
	
КонецПроцедуры


Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения) 

Если ОбменДанными.Загрузка = Истина Тогда
		Возврат;
	КонецЕсли;
	
	ЕстьИзменения = Ложь;
	
	Если ЭтоНовый() Тогда 
		СообщениеДляБота = СтрШаблон("Создана заявка." +Символы.ПС+ "Описание: %1. Специалист: %2. Дата: %3 c %4 до %5",ОписаниеПроблемы,
		Специалист,Формат(ДатаПроведенияРабот,"ДЛФ=DD"),Формат(ВремяНачалаРабот,"ДЛФ=T;"),Формат(ВремяОкончанияРабот,"ДЛФ=T;"));
		ВКМ_Телеграм.СоздатьУведомлениеТелеграмБоту(СообщениеДляБота);	
	Иначе
		ЗаписанныеДанные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, "ОписаниеПроблемы, ДатаПроведенияРабот, ВремяНачалаРабот, ВремяОкончанияРабот, Специалист");
		СообщениеДляБота  = СтрШаблон("Изменена заявка." +Символы.ПС+ "Описание: %1. Специалист: %2. Дата: %3 c %4 до %5", ОписаниеПроблемы,
		Специалист,Формат(ДатаПроведенияРабот,"ДЛФ=DD"),Формат(ВремяНачалаРабот,"ДЛФ=T;"),Формат(ВремяОкончанияРабот,"ДЛФ=T;"));
		Если ЗаписанныеДанные.Специалист <> Специалист Тогда
			ЕстьИзменения = Истина;
			СообщениеДляБота = СообщениеДляБота + Символы.ПС + "Внимание! Изменился Специалист. Был " + ЗаписанныеДанные.Специалист;
		КонецЕсли;
		Если ЗаписанныеДанные.ДатаПроведенияРабот <> ДатаПроведенияРабот Тогда
			ЕстьИзменения = Истина;
			СообщениеДляБота = СообщениеДляБота + Символы.ПС + "Внимание! Изменилась дата выполнения работ. Была " + Формат((ЗаписанныеДанные.ДатаПроведенияРабот),"ДЛФ=DD");
		КонецЕсли;
		Если ЗаписанныеДанные.ВремяНачалаРабот <> ВремяНачалаРабот Тогда
			ЕстьИзменения = Истина;
			СообщениеДляБота = СообщениеДляБота + Символы.ПС + "Внимание! Изменилось время начала работ. Было " + Формат(ЗаписанныеДанные.ВремяНачалаРабот,"ДЛФ=T;");
		КонецЕсли;
		Если ЗаписанныеДанные.ВремяОкончанияРабот <> ВремяОкончанияРабот Тогда
			ЕстьИзменения = Истина;
			СообщениеДляБота = СообщениеДляБота + Символы.ПС + "Внимание! Изменилось время окончания работ. Было " + Формат(ЗаписанныеДанные.ВремяОкончанияРабот,"ДЛФ=T;");
		КонецЕсли;
		
		Если ЕстьИзменения Тогда
			ВКМ_Телеграм.СоздатьУведомлениеТелеграмБоту(СообщениеДляБота);
		КонецЕсли;
		 
	КонецЕсли; 

	
КонецПроцедуры 

#КонецОбласти
#КонецЕсли

