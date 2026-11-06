import sys

sys.path.insert(0, "src")

from lakehouse.spark import get_spark

spark = get_spark()
path = "data/smoke_delta"

spark.createDataFrame([(1, "Rabat")], ["id", "ville"]) \
    .write.format("delta").mode("overwrite").save(path)

spark.createDataFrame([(2, "Casablanca")], ["id", "ville"]) \
    .write.format("delta").mode("append").save(path)

print("Version actuelle :")
spark.read.format("delta").load(path).show()

print("Version 0 (time travel) :")
spark.read.format("delta").option("versionAsOf", 0).load(path).show()

spark.stop()
