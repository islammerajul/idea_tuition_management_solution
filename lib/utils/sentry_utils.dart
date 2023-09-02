import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/material.dart';


class SentryUtils{

   void sentry_exception(String exception,dynamic stackTrace) async{

     await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );

  }

   void sentry_log(String message ,SentryLevel level) async{
     await Sentry.captureMessage(
       message,
       level: level
     );
   }


   void api_performance(String url,String task,String method) async{
    final transaction = Sentry.startTransaction('${task}::${url}', method);

    try {
      await processOrderBatch(transaction);
    } catch (exception) {
      transaction.throwable = exception;
      transaction.status = SpanStatus.internalError();
    } finally {
      await transaction.finish();
    }
  }

  Future<void> processOrderBatch(ISentrySpan span) async {
    // span operation: task, span description: operation
    final innerSpan = span.startChild('task', description: 'operation');

    try {
      // omitted code
    } catch (exception) {
      innerSpan.throwable = exception;
      innerSpan.status = SpanStatus.notFound();
    } finally {
      await innerSpan.finish();
    }
  }





}
