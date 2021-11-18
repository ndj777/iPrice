package com.iPrice;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ParallelTestRunner {
    @Test
    void parallelExecutionAPI() throws IOException {
        File resDir = new File("target/karate-reports");
        if(resDir.exists()){
            FileUtils.deleteDirectory(resDir);
        }
        Results results = Runner.path("classpath:com/iPrice/uiTest").tags("~@ignore").outputCucumberJson(true).parallel(1);
        generateReportAPI(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    public void generateReportAPI(String karateOutputPath)  {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "aircargo-exchange-test");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}