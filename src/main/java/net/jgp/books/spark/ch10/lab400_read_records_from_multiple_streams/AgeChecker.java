package net.jgp.books.spark.ch10.lab400_read_records_from_multiple_streams;

import org.apache.spark.sql.ForeachWriter;
import org.apache.spark.sql.Row;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AgeChecker extends ForeachWriter<Row> {
    private static final long serialVersionUID = 8383715100587612498L;
    private static Logger log = LoggerFactory.getLogger(AgeChecker.class);
    private int streamId = 0;

    public AgeChecker(int streamId) {
        this.streamId = streamId;
    }

    @Override
    public void close(Throwable errorOrNull) {
        if(errorOrNull == null){
            log.info("Closing an AgeChecker instance without any errors.");
        } else {
            log.error("Closing an AgeChecker instance with error", errorOrNull);
        }
    }

    @Override
    public boolean open(long partitionId, long epochId) {
        log.info("Opening an AgeChecker instance with partitionId {} and epochId {}.", partitionId, epochId);
        return true;
    }

    @Override
    public void process(Row row) {
        if (row.length() != 5) {
            return;
        }
        int age = row.getInt(3);
        if (age < 13) {
            log.debug("On stream #{}: {} is a kid, this person is {} yrs old.",
                    streamId,
                    row.getString(0),
                    age);
        } else if (age > 12 && age < 20) {
            log.debug("On stream #{}: {} is a teen, this person is {} yrs old.",
                    streamId,
                    row.getString(0),
                    age);
        } else if (age > 64) {
            log.debug("On stream #{}: {} is a senior, this person is {} yrs old.",
                    streamId,
                    row.getString(0),
                    age);
        } else {
            log.debug("On stream #{}: {} is an adult, this person is {} yrs old.",
                    streamId,
                    row.getString(0),
                    age);
        }
    }
}
