import sys
import os
from hyperon import MeTTa
from agents.pythonAgents.scheduler import ParallelScheduler
from agents.pythonAgents.agent_base import Agentrun

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# change dir so metta working directory remain constant regardless of where it is called
os.chdir(BASE_DIR)

sys.path.append(os.path.dirname(os.path.abspath(__file__)))


def main():

    # create Base dir to allow robust agent path defination
    base_path = os.path.dirname(os.path.abspath(__file__))

    # create a metta instance
    metta = MeTTa()

    # create parallerscheduler instance with metta instance for all agents and a file with all relvent imports
    scheduler = ParallelScheduler(metta, "attention/agents/mettaAgents/paths.metta")

    # load any file that is to be used as knowledge base
    scheduler.load_imports("attention/data/adagram_sm_links.metta")

    # load list of files to for ECAN to read through
    scheduler.load_sent_files(["attention/data/insect-sent.txt", "attention/data/poison-sent.txt"])

    # Optional: adjust parameters
    scheduler.update_attention_param("MAX_AF_SIZE", 7)


    # Register agents
    print("\nRegistering agents...")

    scheduler.register_agent("AFImportanceDiffusionAgent",
        lambda: Agentrun(metta=metta, path=os.path.join(base_path, "agents/mettaAgents/ImportanceDiffusionAgent/AFImportanceDiffusionAgent/AFImportanceDiffusionAgent-runner.metta")))
    scheduler.register_agent("AFRentCollectionAgent",
        lambda: Agentrun(metta=metta, path=os.path.join(base_path, "agents/mettaAgents/RentCollectionAgent/AFRentCollectionAgent/AFRentCollectionAgent-runner.metta")))
    scheduler.register_agent("HebbianUpdatingAgent",
        lambda: Agentrun(metta=metta, path=os.path.join(base_path, "agents/mettaAgents/HebbianUpdatingAgent/HebbianUpdatingAgent-runner.metta")))
    scheduler.register_agent("HebbianCreationAgent",
        lambda: Agentrun(metta=metta, path=os.path.join(base_path, "agents/mettaAgents/HebbianCreationAgent/HebbianCreationAgent-runner.metta")))
    # scheduler.register_agent("WAImportanceDiffusionAgent",
    #     lambda: Agentrun(metta=metta, path=os.path.join(base_path, "agents/mettaAgents/ImportanceDiffusionAgent/WAImportanceDiffusionAgent/WAImportanceDiffusionAgent-runner.metta")))
    # scheduler.register_agent("WARentCollectionAgent",
    #     lambda: Agentrun(metta=metta, path=os.path.join(base_path, "agents/mettaAgents/RentCollectionAgent/WARentCollectionAgent/WARentCollectionAgent-runner.metta")))
    # scheduler.register_agent("ForgettingAgent",
    #     lambda: Agentrun(metta=metta, path=os.path.join(base_path, "agents/mettaAgents/ForgettingAgent/ForgettingAgent-runner.metta")))


    print("\nAgent System Ready!")

    try:
        print("\nRunning agents in continuous mode. Press Ctrl+C to stop.")
        scheduler.run_continuously()
    except KeyboardInterrupt:
        print("\nReceived interrupt signal. Stopping system...")
    except Exception as e:
        print(f"\nError: {e}")

    print("System stopped. Goodbye!")

if __name__ == "__main__":
    main()
